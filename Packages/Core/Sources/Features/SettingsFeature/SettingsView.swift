import ComposableArchitecture
import SwiftUI

public struct SettingsView: View {
    let store: StoreOf<SettingsReducer>

    public init(store: StoreOf<SettingsReducer>) {
        self.store = store
    }

    public var body: some View {
        Text("Settings View")
    }
} 