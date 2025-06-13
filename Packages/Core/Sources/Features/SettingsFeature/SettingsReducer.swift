import AuthClient
import ComposableArchitecture
import SwiftUI

@Reducer
public struct SettingsReducer: Sendable {
    @ObservableState
    public struct State: Equatable {
        var signingOut: Bool = false
        @Presents var errorAlert: AlertState<Action.ErrorAlertAction>?
        public init() {}
    }

    public enum Action {
        public enum ErrorAlertAction: Sendable {
            case ok
        }
        case onTapLogoutButton
        case logout
        case showAlert(any Error)
        case errorAlert(PresentationAction<ErrorAlertAction>)
    }

    @Dependency(\.authClient) var authClient

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTapLogoutButton:
                state.signingOut = true
                return .run { send in
                    do {
                        try self.authClient.signOut()
                        await send(.logout)
                    } catch {
                        await send(.showAlert(error))
                    }
                }
            case .logout:
                state.signingOut = false
                return .none
            case .showAlert(let error):
                state.signingOut = false
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
    }
} 
