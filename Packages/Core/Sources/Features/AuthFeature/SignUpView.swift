import ComposableArchitecture
import Entity
import SwiftUI

public struct SignUpView: View {
    @Bindable var store: StoreOf<SignUpReducer>

    public init(store: StoreOf<SignUpReducer>) {
        self.store = store
    }
    enum CurrentFocus {
        case email
        case password
    }
    @FocusState private var currentFocus: CurrentFocus?

    public var body: some View {
        VStack {
            VStack(spacing: 35) {
                header

                VStack(spacing: 15) {
                    TextField("Email", text: $store.email, prompt: Text("メールアドレス"))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($currentFocus, equals: .email)
                        .padding(13)
                        .roundedBorder(.separator, width: 0.5, radius: 16)
                    SecureField("Password", text: $store.password, prompt: Text("パスワード"))
                        .focused($currentFocus, equals: .password)
                        .padding(13)
                        .roundedBorder(.separator, width: 0.5, radius: 16)
                }

                Button {
                    store.send(.onTapSignUpButton)
                } label: {
                    if store.signingUp {
                        ProgressView()
                    } else {
                        Text("アカウント作成")
                    }
                }
                .buttonStyle(.primary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 52)

            Spacer()
        }
        .disabled(store.signingUp)
        .alert($store.scope(state: \.errorAlert, action: \.errorAlert))
    }
}

extension SignUpView {
    var header: some View {
        VStack {
            Text("新規アカウント作成")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding()

            Text("メールアドレスとパスワードでアカウントを作成")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SignUpView(
        store: .init(
            initialState: .init(),
            reducer: {
                SignUpReducer()
            }
        )
    )
}
