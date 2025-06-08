import Foundation
import ComposableArchitecture

// MARK: - Task Reducer

@Reducer
public struct TaskReducer {
    @ObservableState
    public struct State: Equatable, Sendable {
        public var isLoading = false
        public var taskCount = 0

        public init() {}
    }

    public enum Action {
        case onAppear
        case taskCountIncremented
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = false
                return .none

            case .taskCountIncremented:
                state.taskCount += 1
                return .none
            }
        }
    }
} 
