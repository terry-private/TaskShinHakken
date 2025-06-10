import ComposableArchitecture
import Entity
import SwiftUI

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

                Button {
                    store.send(.onTapLoginButton)
                } label: {
                    if store.logining {
                        ProgressView()
                    } else {
                        Text("ログイン")
                    }
                }
                .buttonStyle(.primary)


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

            }
            .padding()

        }
        .disabled(store.logining)
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
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
            .bold()
            .foregroundColor(isEnabled ? .white : Color(.placeholderText))
            .padding(13)
            .background(isEnabled ? .orange : Color(.secondarySystemFill))
            .opacity(configuration.isPressed ? 0.2 : 1.0) // タップしている間は色を薄く
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .hoverEffect()
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        .init()
    }
}

struct RoundedBorderModifier<Style: ShapeStyle>: ViewModifier {
    var style: Style, width: CGFloat = 0, radius: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(lineWidth: width*2)
                    .fill(style)
            }
            .mask {
                RoundedRectangle(cornerRadius: radius)
            }
    }
}
extension View {
    func roundedBorder<S: ShapeStyle>(
        _ style: S,
        width: CGFloat,
        radius: CGFloat
    ) -> some View {
        let modifier = RoundedBorderModifier(
            style: style,
            width: width,
            radius: radius
        )
        return self.modifier(modifier)
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
