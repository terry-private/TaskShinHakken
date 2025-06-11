import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool

    public func makeBody(configuration: Self.Configuration) -> some View {
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

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        .init()
    }
}

#Preview {
    @Previewable @State var disabled: Bool = true
    @Previewable @State var count: Int = 0
    VStack {
        Text("count: \(count)")
            .monospacedDigit()
        Button("count up!! ") {
            count += 1
        }
        .buttonStyle(.primary)
        .disabled(disabled)

        Text("disabled: \(disabled ? "true" : "false")")

        Button {
            disabled.toggle()
        } label: {
            Label("toggle", systemImage: disabled ? "lightswitch.off" : "lightswitch.on")
        }
        .buttonStyle(.primary)
    }
    .padding()
}
