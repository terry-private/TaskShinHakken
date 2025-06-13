import SwiftUI

public struct AppButtonStyle: ButtonStyle {
    public enum Role {
        case primary
        case secondary
        case destructive

        var foregroundColor: Color {
            switch self {
            case .primary:
                    .white
            case .secondary:
                    .primary
            case .destructive:
                    .red
            }
        }

        var glass: Glass {
            switch self {
            case .primary:
                    .regular.tint(.accentColor).interactive()
            case .secondary:
                    .regular.interactive()
            case .destructive:
                    .regular.interactive()
            }

        }
    }

    @Environment(\.isEnabled) var isEnabled: Bool
    var role: Role

    public init(role: Role) {
        self.role = role
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundColor(isEnabled ? role.foregroundColor : .secondary)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .glassEffect(role.glass, isEnabled: isEnabled)
    }

}

public extension ButtonStyle where Self == AppButtonStyle {
    static func app(_ role: AppButtonStyle.Role = .primary) -> AppButtonStyle {
        .init(role: role)
    }
}

#Preview {
    @Previewable @State var disabled: Bool = true
    @Previewable @State var count: Int = 0
    VStack {
        Text("count: \(count)")
            .monospacedDigit()

        Button("primary count up!! ") {
            count += 1
        }
        .buttonStyle(.app(.primary))
        .disabled(disabled)

        Button("secondary count up!! ") {
            count += 1
        }
        .buttonStyle(.app(.secondary))
        .disabled(disabled)


        Button("destructive count up!! ") {
            count += 1
        }
        .buttonStyle(.app(.destructive))
        .disabled(disabled)

        Text("disabled: \(disabled ? "true" : "false")")

        Button {
            disabled.toggle()
        } label: {
            Label("toggle", systemImage: disabled ? "lightswitch.off" : "lightswitch.on")
                .padding()
        }
        .buttonStyle(.glass)
    }
    .padding()
}
