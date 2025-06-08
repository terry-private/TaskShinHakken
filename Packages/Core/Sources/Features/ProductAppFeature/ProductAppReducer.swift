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
        public init() {}
    }

    public enum Action {
        case mainTab(MainTabReducer.Action)
        case login
        case loginSuceeded(User.ID)
    }

    @Dependency(\.loginClient) var loginClient

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .login:
                state.loading = true
                return .run { send in
                    if let userID = try? await loginClient.login() {
                        await send(.loginSuceeded(userID))
                    }
                }
            case let .loginSuceeded(userID):
                state.mainTab = .init(userID: userID)
                state.loading = false
                return .none
            case .mainTab:
                return .none
            }
        }
        .ifLet(\.mainTab, action: \.mainTab) {
            MainTabReducer()
        }
    }
}
