import SwiftUI

public struct LargeButton<Label: View>: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    var action: @MainActor () -> Void
    var label: Label
    var role: AppButtonStyle.Role

    public init(role: AppButtonStyle.Role = .primary, action: @escaping @MainActor () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
        self.role = role
    }

    public var body: some View {
        Button(action: action) {
            label
                .bold()
                .foregroundColor(isEnabled ? role.foregroundColor : .secondary)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(maxWidth: 300)
                .glassEffect(role.glass, isEnabled: isEnabled)
        }
    }
}

extension LargeButton where Label == Text {
    public init<S>(_ title: S, role: AppButtonStyle.Role = .primary, action: @escaping @MainActor () -> Void) where S : StringProtocol {
        self.action = action
        self.label = Text(title)
        self.role = role
    }
}

#Preview {
    @Previewable @State var disabled: Bool = true
    @Previewable @State var count: Int = 0
    VStack {
        Text("count: \(count)")
            .monospacedDigit()

        LargeButton("primary count up!!") {
            count += 1
        }
        .disabled(disabled)

        LargeButton("secondary count up!!", role: .secondary) {
            count += 1
        }
        .disabled(disabled)


        LargeButton("destructive count up!!", role: .destructive) {
            count += 1
        }
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
