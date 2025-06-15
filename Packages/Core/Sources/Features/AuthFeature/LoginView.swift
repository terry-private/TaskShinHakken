import ComposableArchitecture
import Entity
import SwiftUI
import UIComponents

public struct LoginView: View {
    @Bindable var store: StoreOf<LoginReducer>
    @Environment(\.dismiss) var dismiss

    public init(store: StoreOf<LoginReducer>) {
        self.store = store
    }
    enum CurrentFocus {
        case email
        case password
    }
    @FocusState private var currentFocus: CurrentFocus?

    public var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 35) {
                        header
                        formFields
                        loginActions
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()

                Button("新規アカウント作成") {
                    store.send(.onTapSignUpButton)
                }
                .padding()

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .disabled(store.loading)
            .interactiveDismissDisabled(store.loading)
            .alert($store.scope(state: \.errorAlert, action: \.errorAlert))
            .alert($store.scope(state: \.alert, action: \.alert))
            .navigationDestination(item: $store.scope(state: \.signUp, action: \.signUp)) { store in
                SignUpView(store: store)
            }
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

    var formFields: some View {
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
                Button {
                    store.send(.onTapForgetPasswordButton)
                } label: {
                    Text("パスワードをお忘れの方")
                        .font(.caption)
                }
            }
        }
    }

    var loginActions: some View {
        VStack(spacing: 16) {
            LargeButton {
                store.send(.onTapLoginButton)
            } label: {
                if store.loading {
                    ProgressView()
                } else {
                    Text("ログイン")
                }
            }

            Text("または")
                .font(.caption)
                .foregroundStyle(.secondary)

            LargeButton(role: .secondary) {
                store.send(.onTapAppleSignInButton)
            } label: {
                Label("Appleでサインイン", systemImage: "apple.logo")
            }
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
