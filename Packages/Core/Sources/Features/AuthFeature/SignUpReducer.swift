import ComposableArchitecture
import AuthClient
import Entity

@Reducer
public struct SignUpReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        var email: String = ""
        var password: String = ""
        var signingUp: Bool = false
        @Presents var errorAlert: AlertState<Action.ErrorAlertAction>?

        public init() {}
    }

    public enum Action: BindableAction {
        public enum ErrorAlertAction: Sendable {
            case ok
        }
        case binding(BindingAction<State>)
        case onTapSignUpButton
        case signUpSucceeded(User.ID)
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
            case .onTapSignUpButton:
                state.signingUp = true
                guard let email = EMail(rawValue: state.email) else {
                    state.signingUp = false
                    state.errorAlert = AlertState {
                        TextState("メールアドレスが間違っています。")
                    }
                    return .none
                }
                let password = state.password
                return .run { send in
                    do {
                        let userID = try await self.authClient.signUp(email, password)
                        await send(.signUpSucceeded(userID))
                    } catch {
                        await send(.showAlert(error))
                    }
                }

            case .signUpSucceeded:
                state.signingUp = false
                return .none

            case .showAlert(let error):
                state.signingUp = false
                if let authError = error as? AuthError {
                    switch authError {
                    case .invalidEmail:
                        state.errorAlert = AlertState(title: {
                            TextState("メールアドレスが間違っています。")
                        })
                    default:
                        state.errorAlert = AlertState(title: {
                            TextState("アカウント作成に失敗しました")
                        })
                    }
                } else {
                    state.errorAlert = AlertState(title: {
                        TextState("アカウント作成に失敗しました")
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
