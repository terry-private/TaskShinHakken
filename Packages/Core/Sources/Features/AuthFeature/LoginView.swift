import ComposableArchitecture
import Entity
import SwiftUI
import UIComponents

public struct LoginView: View {
    @Bindable var store: StoreOf<LoginReducer>

    public init(store: StoreOf<LoginReducer>) {
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
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("パスワードをお忘れの方")
                                .font(.caption)
                        }
                    }
                }

                LargeButton {
                    store.send(.onTapLoginButton)
                } label: {
                    if store.logining {
                        ProgressView()
                    } else {
                        Text("ログイン")
                    }
                }


                Text("または")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button("Google Login") {
                    // Call Google Login Logic
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 52)

            Spacer()

            Button("新規アカウント作成") {
                store.send(.onTapSignUpButton)
            }
            .padding()

        }
        .disabled(store.logining)
        .alert($store.scope(state: \.errorAlert, action: \.errorAlert))
        .sheet(item: $store.scope(state: \.signUp, action: \.signUp)) { store in
            SignUpView(store: store)
        }
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
