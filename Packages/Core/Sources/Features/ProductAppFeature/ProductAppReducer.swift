import SwiftUI
import ComposableArchitecture
import TaskFeature

@Reducer
public struct ProductAppReducer {
    @ObservableState
    public struct State: Equatable {
        public var taskFeature = TaskReducer.State()
        
        public init() {}
    }
    
    public enum Action {
        case taskFeature(TaskReducer.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.taskFeature, action: \.taskFeature) {
            TaskReducer()
        }
    }
}

// MARK: - Product App Root View

