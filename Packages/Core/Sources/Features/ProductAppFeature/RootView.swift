import SwiftUI
import AuthClient
import ComposableArchitecture

public struct RootView: View {

    public init() {}

    public var body: some View {
        ProductAppView(
            store: Store(initialState: ProductAppReducer.State()) {
                ProductAppReducer()
            }
        )
    }
}
