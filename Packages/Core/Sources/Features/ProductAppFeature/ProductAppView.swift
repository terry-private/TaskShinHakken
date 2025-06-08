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
        bodyView
    }

    @ViewBuilder
    private var bodyView: some View {
        TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
            Tab(ProductAppReducer.Tab.home.name, systemImage: "house", value: .home) {
                HomeView(store: store.scope(state: \.home, action: \.home))
            }
            Tab(ProductAppReducer.Tab.task.name, systemImage: "list.bullet", value: .task) {
                TaskView(store: store.scope(state: \.task, action: \.task))
            }
            Tab(ProductAppReducer.Tab.settings.name, systemImage: "gear", value: .settings) {
                SettingsView(store: store.scope(state: \.settings, action: \.settings))
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ProductAppView(
        store: Store(initialState: ProductAppReducer.State()) {
            ProductAppReducer()
        }
    )
}
