import SwiftUI
import ComposableArchitecture
import TaskFeature
import HomeFeature
import SettingsFeature

@Reducer
public struct ProductAppReducer {
    @ObservableState
    public enum Tab {
        case home
        case task
        case settings

        var name: String {
            switch self {
            case .home:
                return "Home"
            case .task:
                return "Task"
            case .settings:
                return "Settings"
            }
        }
    }

    @ObservableState
    public struct State: Equatable {
        public var selectedTab: Tab = .home
        @Presents public var detail: DetailReducer.State?
        public var home: HomeReducer.State = .init()
        public var settings: SettingsReducer.State = .init()
        public var task: TaskReducer.State = .init()

        public init() {}
    }
    
    public enum Action {
        case tabSelected(Tab)
        case detail(PresentationAction<DetailReducer.Action>)
        case home(HomeReducer.Action)
        case task(TaskReducer.Action)
        case settings(SettingsReducer.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        Scope(state: \.task, action: \.task) {
            TaskReducer()
        }
        Scope(state: \.settings, action: \.settings) {
            SettingsReducer()
        }

        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            
            case .detail(.presented(.delegate(.someAction))):
                // Handle delegate action from DetailReducer
                return .none

            case .home, .task, .settings, .detail:
                return .none
            }
        }
        .ifLet(\.$detail, action: \.detail) {
            DetailReducer()
        }
    }
}

@Reducer
public struct DetailReducer {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case delegate(Delegate)

        public enum Delegate {
            case someAction
        }
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            .none
        }
    }
}
