import SwiftUI
import ComposableArchitecture

// MARK: - Task View

public struct TaskView: View {
    @Bindable public var store: StoreOf<TaskReducer>
    
    public init(store: StoreOf<TaskReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("タスクしん発見！")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("あなたのタスクを手助けする「しん」達を発見しよう")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                HStack {
                    Text("完了したタスク:")
                        .font(.headline)
                    Spacer()
                    Text("\(store.taskCount)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                
                Button("タスクを完了") {
                    store.send(.taskCountIncremented)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    TaskView(
        store: Store(initialState: TaskReducer.State()) {
            TaskReducer()
        }
    )
}
