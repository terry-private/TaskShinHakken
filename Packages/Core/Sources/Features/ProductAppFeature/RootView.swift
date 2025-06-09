import SwiftUI
import CoreClient
import CoreClientProduct
import ComposableArchitecture

public struct RootView: View {

    public init() {}

    public var body: some View {
        ProductAppView(
            store: Store(initialState: ProductAppReducer.State()) {
                withDependencies {
                    $0.loginClient = .product
                } operation: {
                    ProductAppReducer()
                }
            }
        )
    }
}
