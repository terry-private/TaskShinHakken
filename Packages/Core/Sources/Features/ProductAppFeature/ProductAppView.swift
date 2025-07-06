import AuthFeature
import ComposableArchitecture
import MainTabFeature
import SwiftUI

public struct ProductAppView: View {
    @Bindable var store: StoreOf<ProductAppReducer>

    public init(store: StoreOf<ProductAppReducer>) {
        self.store = store
    }

    public var body: some View {
        Group {
            if let store = store.scope(state: \.mainTab, action: \.mainTab) {
                MainTabView(store: store)
            } else {
                Color.gray
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .overlay {
                        if store.loading || store.checkingSetupStatus {
                            VStack {
                                ProgressView()
                                Text(store.checkingSetupStatus ? "セットアップ状態を確認中..." : "読み込み中...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.top, 8)
                            }
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
        .onAppear {
            store.send(.autoLogin)
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
