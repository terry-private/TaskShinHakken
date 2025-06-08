import ComposableArchitecture
import SwiftUI

@Reducer
public struct SettingsReducer {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {}

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, _ in
            .none
        }
    }
} 
