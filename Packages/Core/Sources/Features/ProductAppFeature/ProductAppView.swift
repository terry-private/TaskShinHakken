import ComposableArchitecture
import SwiftUI
import HomeFeature
import SettingsFeature
import TaskFeature

public struct ProductAppView: View {
    @Bindable var store: StoreOf<ProductAppReducer>

    public init(store: StoreOf<ProductAppReducer>) {
        self.store = store
    }

    public var body: some View {
        if let store = store.scope(state: \.mainTab, action: \.mainTab) {
            MainTabView(store: store)
        } else {
            if store.loading {
                ProgressView()
            } else {
                Button("ログイン") {
                    store.send(.login)
                }
            }
        }
    }
}

#Preview {
    ProductAppView(
        store: Store(initialState: ProductAppReducer.State()) {
            ProductAppReducer()
        }
    )
}
