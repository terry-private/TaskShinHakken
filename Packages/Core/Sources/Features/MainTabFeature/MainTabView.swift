import ComposableArchitecture
import SwiftUI
import HomeFeature
import SettingsFeature
import TaskFeature

public struct MainTabView: View {
    @Bindable var store: StoreOf<MainTabReducer>

    public init(store: StoreOf<MainTabReducer>) {
        self.store = store
    }

    public var body: some View {
        bodyView
    }

    @ViewBuilder
    private var bodyView: some View {
        TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
            Tab(MainTabReducer.Tab.home.name, systemImage: "house", value: .home) {
                HomeView(store: store.scope(state: \.home, action: \.home))
            }
            Tab(MainTabReducer.Tab.task.name, systemImage: "list.bullet", value: .task) {
                TaskView(store: store.scope(state: \.task, action: \.task))
            }
            Tab(MainTabReducer.Tab.settings.name, systemImage: "gear", value: .settings) {
                SettingsView(store: store.scope(state: \.settings, action: \.settings))
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView(
        store: Store(initialState: MainTabReducer.State(userID: "test")) {
            MainTabReducer()
        }
    )
}
