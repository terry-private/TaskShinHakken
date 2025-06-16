import ComposableArchitecture
import AuthClient
import Entity

@Reducer
public struct LoginReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        var email: String = ""
        var password: String = ""
        var loading: Bool = false
        @Presents var errorAlert: AlertState<Action.SimpleAlertAction>?
        @Presents var signUp: SignUpReducer.State?
        @Presents var alert: AlertState<Action.SimpleAlertAction>?

        public init() {}
    }

    public enum Action: BindableAction {
        public enum SimpleAlertAction: Sendable {
            case ok
        }
        case binding(BindingAction<State>)
        case onTapLoginButton
        case loginSucceeded(User.ID)
        case showAlert(any Error)
        case showSendPasswordResetEmailSucceededAlert
        case errorAlert(PresentationAction<SimpleAlertAction>)
        case alert(PresentationAction<SimpleAlertAction>)
        case onTapSignUpButton
        case signUp(PresentationAction<SignUpReducer.Action>)
        case onTapAppleSignInButton
        case onTapForgetPasswordButton
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
                state.loading = true
                guard let email = EMail(rawValue: state.email) else {
                    state.loading = false
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
                state.loading = false
                return .none

            case .showAlert(let error):
                state.loading = false
                if let authError = error as? AuthError {
                    switch authError {
                    case .invalidEmail:
                        state.errorAlert = AlertState(title: {
                            TextState("メールアドレスが間違っています。")
                        })
                    default:
                        state.errorAlert = AlertState(title: {
                            TextState("ログインに失敗しました。")
                        })
                    }
                } else {
                    state.errorAlert = AlertState(title: {
                        TextState("ログインに失敗しました。")
                    })
                }

                return .none
            case .showSendPasswordResetEmailSucceededAlert:
                state.loading = false
                state.alert = AlertState(title: {
                    TextState("パスワード再設定メールを送りました。")
                })
                return .none
            case .errorAlert:
                state.errorAlert = nil
                return .none
            case .alert:
                state.alert = nil
                return .none

            case .onTapSignUpButton:
                state.signUp = SignUpReducer.State()
                return .none
            case .signUp:
                return .none
            case .onTapAppleSignInButton:
                return .run { send in
                    do {
                        let userID = try await authClient.appleSignIn()
                        await send(.loginSucceeded(userID))
                    } catch {
                        await send(.showAlert(error))
                    }
                }
            case .onTapForgetPasswordButton:
                guard let email = EMail(rawValue: state.email) else {
                    state.loading = false
                    state.errorAlert = AlertState {
                        TextState("メールアドレスが間違っています。")
                    }
                    return .none
                }
                return .run { send in
                    do {
                        try await authClient.sendPasswordResetEmail(email)
                        await send(.showSendPasswordResetEmailSucceededAlert)
                    } catch {
                        await send(.showAlert(error))
                    }
                }
            }
        }
        .ifLet(\.errorAlert, action: \.errorAlert)
        .ifLet(\.alert, action: \.alert)
        .ifLet(\.$signUp, action: \.signUp) {
            SignUpReducer()
        }
    }
}

