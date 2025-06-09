import ComposableArchitecture
import CoreClient
import Entity

@Reducer
public struct LoginReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        var email: String = ""
        var password: String = ""
        var logining: Bool = false

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onTapLoginButton
        case loginSucceeded(User.ID)
    }

    @Dependency(\.loginClient) var loginClient

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .onTapLoginButton:
                state.logining = true
                guard let email = EMail(rawValue: state.email) else {
                    state.logining = false
                    return .none
                }
                let password = state.password
                return .run { send in
                    if let userID = try? await self.loginClient.login(email, password) {
                        await send(.loginSucceeded(userID))
                    }
                }
            case .loginSucceeded:
                state.logining = false
                return .none
            }
        }
    }
}
