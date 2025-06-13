import ComposableArchitecture
import SwiftUI
import UIComponents

public struct SettingsView: View {
    let store: StoreOf<SettingsReducer>

    public init(store: StoreOf<SettingsReducer>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            LargeButton("ログアウト", role: .destructive) {
                store.send(.onTapLogoutButton)
            }
            .navigationTitle("設定")
        }
    }
} 

#Preview {
    SettingsView(
        store: Store(
            initialState: .init(),
            reducer: {
                SettingsReducer()
            }
        )
    )
}
