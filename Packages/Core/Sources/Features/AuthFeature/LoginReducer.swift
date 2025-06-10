import ComposableArchitecture
import AuthClient
import Entity

@Reducer
public struct LoginReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        var email: String = ""
        var password: String = ""
        var logining: Bool = false
        @Presents var errorAlert: AlertState<Action.ErrorAlertAction>?

        public init() {}
    }

    public enum Action: BindableAction {
        public enum ErrorAlertAction: Sendable {
            case ok
        }
        case binding(BindingAction<State>)
        case onTapLoginButton
        case loginSucceeded(User.ID)
        case showAlert(any Error)
        case errorAlert(PresentationAction<ErrorAlertAction>)
    }

    @Dependency(\.authClient) var authClient

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
                    state.errorAlert = AlertState {
                        TextState("メールアドレスが間違っています。")
                    }
                    return .none
                }
                let password = state.password
                return .run { send in
                    do {
                        let userID = try await self.authClient.login(email, password)
                        await send(.loginSucceeded(userID))
                    } catch {
                        await send(.showAlert(error))
                    }
                }

            case .loginSucceeded:
                state.logining = false
                return .none

            case .showAlert(let error):
                state.logining = false
                if let loginError = error as? LoginError {
                    switch loginError {
                    case .invalidEmail:
                        state.errorAlert = AlertState(title: {
                            TextState("メールアドレスが間違っています。")
                        })
                    default:
                        state.errorAlert = AlertState(title: {
                            TextState("ログインに失敗しました")
                        })
                    }
                } else {
                    state.errorAlert = AlertState(title: {
                        TextState("ログインに失敗しました")
                    })
                }

                return .none
            case .errorAlert:
                state.errorAlert = nil
                return .none
            }
        }
        .ifLet(\.errorAlert, action: \.errorAlert)
    }
}
