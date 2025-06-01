import ComposableArchitecture
import SwiftUI
import TaskFeature

public struct ProductAppView: View {
    let store: StoreOf<ProductAppReducer>

    public init(store: StoreOf<ProductAppReducer>) {
        self.store = store
    }

    public var body: some View {
        TaskView(
            store: store.scope(
                state: \.taskFeature,
                action: \.taskFeature
            )
        )
    }
}
