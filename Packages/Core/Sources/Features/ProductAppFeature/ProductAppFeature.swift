import SwiftUI
import ComposableArchitecture
import TaskFeature

// MARK: - Product App Feature

@Reducer
public struct ProductAppFeature {
    @ObservableState
    public struct State: Equatable {
        public var taskFeature = TaskFeature.State()
        
        public init() {}
    }
    
    public enum Action {
        case taskFeature(TaskFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.taskFeature, action: \.taskFeature) {
            TaskFeature()
        }
    }
}

// MARK: - Product App Root View

public struct ProductAppRootView: View {
    let store: StoreOf<ProductAppFeature>
    
    public init(store: StoreOf<ProductAppFeature>) {
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

// MARK: - Public API (TCAを隠蔽)

public struct TaskShinHakkenApp {
    public static func createRootView() -> some View {
        ProductAppRootView(
            store: Store(initialState: ProductAppFeature.State()) {
                ProductAppFeature()
            }
        )
    }
    
    private init() {} // インスタンス化を防ぐ
}
