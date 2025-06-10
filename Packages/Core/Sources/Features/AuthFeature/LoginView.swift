import ComposableArchitecture
import Entity
import SwiftUI

public struct LoginView: View {
    @Bindable var store: StoreOf<LoginReducer>

    public init(store: StoreOf<LoginReducer>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            VStack {
                header
                    .padding(.bottom)

                CustomTextfield(placeholder: "メールアドレス", text: $store.email)
                CustomTextfield(placeholder: "パスワード",text: $store.password, isSecret: true)

                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password?")
                    }
                }
                .padding(.trailing, 24)

                loginButton


                Text("or")
                    .padding()

                Button("Google Login!!") {
                    // Call Google Login Logic
                }
            }
            .padding(.top, 52)
            Spacer()

            Button("新規アカウント作成") {

            }
            .padding()
        }
        .alert($store.scope(state: \.errorAlert, action: \.errorAlert))
    }
}

extension LoginView {
    var header: some View {
        VStack {
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding()

            Text("メールアドレスとパスワードでログイン")
                .multilineTextAlignment(.center)
        }
    }
    var loginButton: some View {
        Button {
            store.send(.onTapLoginButton)
        } label: {
            HStack {
                Spacer()
                if store.logining {
                    ProgressView()
                } else {
                    Text("ログイン")
                        .bold()
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(13)
            .background(.orange)
            .cornerRadius(12)
        }
        .disabled(store.logining)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    }
}

struct CustomTextfield: View {
    @Binding var text: String
    var placeholder: String
    var isSecret: Bool
    init(placeholder: String = "", text: Binding<String>, isSecret: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.isSecret = isSecret
    }

    @ViewBuilder
    var textField: some View {
        if isSecret {
            SecureField(placeholder, text: $text)
        } else {
            TextField(placeholder, text: $text)
        }
    }

    var body: some View {
        textField
            .padding(13)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 0.5)
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
    }
}
#Preview {
    LoginView(
        store: .init(
            initialState: .init(),
            reducer: {
                LoginReducer()
            }
        )
    )
}
