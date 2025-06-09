import AuthFeature
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
            Color.gray
                .opacity(0.3)
                .ignoresSafeArea()
                .overlay {
                    if store.loading {
                        ProgressView()
                    } else {
                        Button("ログイン") {
                            store.send(.loginButtonTapped)
                        }
                    }
                }
                .sheet(item: $store.scope(state: \.login, action: \.login)) { store in
                    LoginView(store: store)
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
