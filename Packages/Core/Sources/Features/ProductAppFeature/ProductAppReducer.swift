import AuthFeature
import ComposableArchitecture
import CoreClient
import Entity
import HomeFeature
import SettingsFeature
import SwiftUI
import TaskFeature

@Reducer
public struct ProductAppReducer: Sendable {
    @ObservableState
    public struct State: Equatable {
        var mainTab: MainTabReducer.State?
        var loading: Bool = false
        @Presents var login: LoginReducer.State?
        public init() {}
    }

    public enum Action {
        case mainTab(MainTabReducer.Action)
        case login(PresentationAction<LoginReducer.Action>)
        case loginButtonTapped
    }

    @Dependency(\.loginClient) var loginClient

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                state.login = LoginReducer.State()
                return .none
            case .login(.presented(.loginSucceeded(let userID))):
                state.login = nil
                state.mainTab = .init(userID: userID)
                return .none
            case .login:
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
