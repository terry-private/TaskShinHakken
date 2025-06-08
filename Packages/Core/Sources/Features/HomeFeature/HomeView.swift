import ComposableArchitecture
import SwiftUI

public struct HomeView: View {
    let store: StoreOf<HomeReducer>

    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }

    public var body: some View {
        Text("Home View")
    }
} 