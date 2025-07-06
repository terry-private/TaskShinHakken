import AuthFeature
import ComposableArchitecture
import AuthClient
import UserClient
import Entity
import MainTabFeature
import SwiftUI

@Reducer
public struct ProductAppReducer: Sendable {
    @ObservableState
    public struct State: Equatable {
        var mainTab: MainTabReducer.State?
        var loading: Bool = false
        var checkingSetupStatus: Bool = false
        @Presents var login: LoginReducer.State?
        public init() {}
    }

    public enum Action {
        case mainTab(MainTabReducer.Action)
        case login(PresentationAction<LoginReducer.Action>)
        case loginButtonTapped
        case autoLogin
        case checkSetupStatus(Entity.User.ID)
        case setupStatusReceived(Bool, Entity.User.ID)
    }

    @Dependency(\.authClient) var authClient
    @Dependency(\.userClient) var userClient

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .autoLogin:
                if let userID = authClient.autoLogin() {
                    return .run { send in
                        await send(.checkSetupStatus(userID))
                    }
                }
                return .none
            case .loginButtonTapped:
                state.login = LoginReducer.State()
                return .none
            case .login(.presented(.loginSucceeded(let userID))):
                state.login = nil
                return .run { send in
                    await send(.checkSetupStatus(userID))
                }
            case .login(.presented(.signUp(.presented(.signUpSucceeded(let userID))))):
                state.login = nil
                return .run { send in
                    await send(.checkSetupStatus(userID))
                }
            case .checkSetupStatus(let userID):
                state.checkingSetupStatus = true
                return .run { send in
                    do {
                        let isSetupCompleted = try await userClient.getUserSetupStatus(userID)
                        await send(.setupStatusReceived(isSetupCompleted, userID))
                    } catch {
                        // エラー時は一旦セットアップ完了とみなしてMainTabへ遷移
                        await send(.setupStatusReceived(true, userID))
                    }
                }
            case .setupStatusReceived(let isSetupCompleted, let userID):
                state.checkingSetupStatus = false
                
                if isSetupCompleted {
                    // セットアップ完了済みの場合はMainTabへ遷移
                    state.mainTab = .init(userID: userID)
                } else {
                    // 未セットアップの場合は将来的にSetupFeatureへ遷移
                    // TODO: SetupFeature実装後に変更
                    state.mainTab = .init(userID: userID)
                }
                return .none
            case .login:
                return .none
            case .mainTab(.settings(.logout)):
                state.mainTab = nil
                return .none
            case .mainTab:
                return .none
            }
        }
        .ifLet(\.mainTab, action: \.mainTab) {
            MainTabReducer()
        }
        .ifLet(\.$login, action: \.login) {
            LoginReducer()
        }
    }
}
