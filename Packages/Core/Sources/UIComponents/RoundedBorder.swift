import SwiftUI

public struct RoundedBorderModifier<Style: ShapeStyle>: ViewModifier {
    public var style: Style, width: CGFloat = 0, radius: CGFloat

    public func body(content: Content) -> some View {
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

public extension View {
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
