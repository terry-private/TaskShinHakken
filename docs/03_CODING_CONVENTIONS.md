# 03 コーディング規約 - タスクしん発見！

## 1. はじめに

このドキュメントは、タスクしん発見！プロジェクトにおけるSwiftコードの記述スタイル、命名規則、フォーマット、およびコメント規約を定義します。これらの規約に従うことで、コードの一貫性と保守性を高め、特にAIエージェントとの協調作業を円滑にします。

**適用範囲:**
- すべてのSwiftソースファイル（`.swift`）
- SwiftUIビューの実装
- TCAのフィーチャー実装
- テストコード

**目標:**
- コードの可読性と保守性の向上
- チーム間での一貫した開発体験
- AIエージェントによるコード生成・理解の促進

## 2. 一般原則

### 2.1. 基本方針

1. **Swift API Design Guidelinesの遵守**: [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) を基本として従う
2. **読みやすさ重視**: コードは書くより読まれることの方が多いことを意識
3. **シンプルさ**: 過度に複雑な実装を避け、明確で理解しやすいコードを書く
4. **安全性**: コンパイル時の型安全性を最大限活用し、実行時エラーを防ぐ
5. **一貫性**: プロジェクト全体で統一されたスタイルを維持

### 2.2. Swiftバージョン

- **対象バージョン**: Swift 6.0以降
- **言語機能**: 最新の安全性機能（Strict Concurrency等）を積極的に活用
- **Concurrency**: async/await、MainActor、Sendableを適切に使用

### 2.3. Swift 6.0 Concurrency対応

**Sendable準拠**: データ競合を防ぐため、型がアクター間で安全に共有可能であることを示す`Sendable`プロトコルに準拠します。

```swift
// ✅ 良い例：StateとActionがSendableであれば、Reducerは通常、暗黙的にSendableに準拠します。
// 明示的な準拠は不要な場合が多いです。
@Reducer
public struct SimplerReducer {
    @ObservableState
    public struct State: Equatable, Sendable { /* ... */ }
    public enum Action: Sendable { /* ... */ }
    // bodyなど
}

// ⚠️ 注意：明示的なSendable準拠が必要なケース
// - StateまたはActionがSendableに準拠していない場合
// - 依存関係(Dependency)に非Sendableな型が含まれる場合
// - 将来的な変更に備えて、明示的にSendableであることを保証したい場合
@Reducer
public struct ExplicitlySendableReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable { /* ... */ }
    public enum Action: Sendable { /* ... */ }
    // bodyなど
}
```

**MainActor指定**: UI関連の処理は`MainActor`で実行されることを保証します。

```swift
// ✅ 良い例：MainActorが必須なカスタムクラスや、UIを操作する関数
@MainActor
class CustomUIUpdater {
    func updateUI() { /* UI更新ロジック */ }
}

// ❌ 悪い例：ViewおよびAppプロトコル準拠型への冗長な@MainActor指定
// Viewプロトコルに準拠する型は、そのbodyプロパティを含め、暗黙的にMainActorで実行されます。
// 明示的な@MainActorは冗長であり、規約違反とします。
@MainActor // 冗長なため削除
public struct TaskView: View { ... }

// Appプロトコルに準拠する型も同様に、暗黙的にMainActorで実行されます。
@main
@MainActor // 冗長なため削除
struct TaskShinHakken_ProductApp: App { ... }
```

**並行処理の安全性**: データ競合を防ぐための原則

```swift
// ✅ 良い例：非同期処理でのactor境界の明確化
case .loadTasks:
    state.isLoading = true
    return .run { send in // .runクロージャ内は非同期コンテキスト
        do {
            // taskService.fetchTasks() は actor隔離されているか、グローバルアクターで実行される想定
            let tasks = try await dependencies.taskService.fetchTasks()
            // send は MainActor で実行される必要がある場合がある
            await send(.tasksLoaded(tasks))
        } catch {
            await send(.loadTasksFailed(error))
        }
    }

// ✅ 良い例：Viewのbody外でUIを更新する必要がある場合など、MainActorでの実行を明示
nonisolated func updateGlobalUIState() { // nonisolatedな関数からUIを更新する場合
    MainActor.assumeIsolated { // MainActorコンテキストであることを表明
        // グローバルなUI状態の更新
    }
}
```

## 3. 命名規則

### 3.1. 型（Types）

**UpperCamelCase**を使用します。

```swift
// ✅ 良い例
struct TaskItem { }
class ShinCharacter { }
enum TaskStatus { }
protocol TaskManaging { }

// ❌ 悪い例
struct taskItem { }
class shin_character { }
```

### 3.2. 関数・メソッド、変数・定数

**lowerCamelCase**を使用します。

```swift
// ✅ 良い例
func fetchTasks() async throws -> [TaskItem] { }
let currentUser: User = .init()
var isLoading: Bool = false

// ❌ 悪い例
func FetchTasks() { }
let current_user: User = .init()
```

### 3.3. Enumケース

**lowerCamelCase**を推奨します。

```swift
// ✅ 推奨
enum TaskStatus {
    case notStarted
    case inProgress
    case completed
    case cancelled
}

// ✅ 許容（既存のSwift標準ライブラリとの一貫性がある場合）
enum NetworkError {
    case InvalidURL
    case ConnectionFailed
}
```

### 3.4. TCA固有の命名規則

**Action**: UpperCamelCaseで動詞形を推奨

```swift
// ✅ 良い例
enum TaskFeatureAction {
    case ViewAppeared
    case TaskItemTapped(TaskItem.ID)
    case LoadTasksResponse(Result<[TaskItem], Error>)
    case CompleteTaskButtonTapped(TaskItem.ID)
}

// ❌ 悪い例
enum TaskFeatureAction {
    case viewAppeared  // 小文字始まり
    case task(TaskItem)  // 動詞でない
    case response  // 具体性が不足
}
```

**State**: 構造体名としてUpperCamelCase

```swift
// ✅ 良い例
struct TaskFeatureState: Equatable {
    var tasks: [TaskItem] = []
    var isLoading: Bool = false
    var selectedTask: TaskItem?
}
```

**Reducer**: モジュール名との衝突を回避するため、`Reducer`サフィックスを使用。`State`と`Action`が`Sendable`であれば、通常`Reducer`自体への明示的な`Sendable`準拠は不要です。

```swift
// ✅ 良い例（モジュール名: TaskFeature）
// StateとActionがSendableなため、TaskReducerは暗黙的にSendable
@Reducer
public struct TaskReducer {
    @ObservableState
    public struct State: Equatable, Sendable { /* ... */ }
    public enum Action: Sendable { /* ... */ }
    // bodyなど
}

// ❌ 悪い例（モジュール名と同じ名前）
// モジュール名「TaskFeature」と衝突
@Reducer
public struct TaskFeature { ... }

// ⚠️ 注意：明示的なSendable準拠が必要な場合
@Reducer
public struct MyComplexReducer: Sendable { ... }
```

**命名衝突回避の原則**:
- モジュール名（フォルダ名）とstruct/class名を同じにしない
- Reducerには必ず`Reducer`サフィックスを付ける
- モジュール内の主要な型には、機能を表す明確な名前を付ける

### 3.5. ブーリアン値

`is...`, `has...`, `can...`, `should...`, `will...`, `did...`などの接頭辞を使用

```swift
// ✅ 良い例
var isLoading: Bool = false
var isTaskCompleted: Bool = false
var hasNetworkConnection: Bool = true
var canEditTask: Bool = false
var shouldShowAlert: Bool = false

// ❌ 悪い例
var loading: Bool = false
var taskCompleted: Bool = false
var networkConnection: Bool = true
```

## 4. フォーマット

### 4.1. インデント

- **4つのスペース**を使用（Xcode標準）
- タブ文字は使用しない

### 4.2. 行の長さ

- **120文字以内**を推奨
- 長い行は適切な位置で改行し、読みやすさを優先

```swift
// ✅ 良い例
func fetchTasksForUser(
    userId: String,
    includeCompleted: Bool = false,
    sortOrder: TaskSortOrder = .dateCreated
) async throws -> [TaskItem] {
    // 実装
}

// ❌ 悪い例（長すぎる）
func fetchTasksForUser(userId: String, includeCompleted: Bool = false, sortOrder: TaskSortOrder = .dateCreated) async throws -> [TaskItem] {
    // 実装
}
```

### 4.3. スペースと括弧

```swift
// ✅ 良い例
if condition {
    // 処理
}

for item in items {
    // 処理
}

let result = items.map { $0.name }

// ❌ 悪い例
if(condition){
    // 処理
}

for item in items{
    // 処理
}
```

### 4.4. 改行

- 関数間に1行の空行を入れる
- ロジックの塊の間に適切に空行を入れる

```swift
struct TaskFeature: Reducer {
    struct State: Equatable {
        var tasks: [TaskItem] = []
        var isLoading: Bool = false
    }
    
    enum Action {
        case viewAppeared
        case loadTasks
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .send(.loadTasks)
                
            case .loadTasks:
                state.isLoading = true
                return .run { send in
                    // 非同期処理
                }
            }
        }
    }
}
```

### 4.5. SwiftFormat設定

**`.swiftformat`設定ファイル例:**

```
--indent 4
--linebreaks lf
--maxwidth 120
--wraparguments before-first
--wrapcollections before-first
--closingparen balanced
--commas inline
--trimwhitespace always
--ifdef no-indent
--redundanttype inferred
```

## 5. コメントとドキュメンテーション

### 5.1. コメントのガイドライン

**コメントが必要な場面:**
- 複雑なビジネスロジック
- 非自明なアルゴリズム
- 重要な前提条件や制約
- 外部APIとの連携部分
- ワークアラウンドの説明

```swift
// ✅ 良い例
/// 「しん」の成長レベルを計算します
/// 
/// タスクの完了数と種類に基づいて、対応する「しん」の成長レベルを決定します。
/// - Parameter completedTasks: 完了したタスクの配列
/// - Parameter shinType: 成長させる「しん」の種類
/// - Returns: 新しい成長レベル（0-100の範囲）
/// - Throws: `ShinGrowthError` タスクデータが不正な場合
func calculateShinGrowthLevel(
    completedTasks: [TaskItem],
    shinType: ShinType
) throws -> Int {
    // タスクの種類と「しん」の対応を確認
    // しんのタイプごとに重み付けを変える必要がある
    let relevantTasks = completedTasks.filter { task in
        task.associatedShinTypes.contains(shinType)
    }
    
    // 成長レベルの計算（0-100の範囲に正規化）
    let growthPoint = relevantTasks.count * shinType.baseGrowthMultiplier
    return min(growthPoint, 100)
}
```

### 5.2. ドキュメンテーションコメント

`///`を使用してドキュメンテーションコメントを記述：

```swift
/// タスク管理のメイン機能を提供するTCAフィーチャー
///
/// このフィーチャーは以下の責務を持ちます：
/// - タスクの一覧表示
/// - タスクの完了/未完了の切り替え
/// - 新しいタスクの追加
/// - Firebaseとの同期
struct TaskFeature: Reducer {
    // ...
}
```

## 6. Swift言語機能の利用方針

### 6.1. オプショナル

**強制アンラップ（`!`）の回避**

```swift
// ✅ 良い例
if let user = currentUser {
    updateUI(for: user)
}

guard let taskId = task.id else {
    return .none
}

// Nil-coalescing演算子の活用
let displayName = user.name ?? "名前未設定"

// ❌ 悪い例（強制アンラップ）
let user = currentUser!  // クラッシュの可能性
```

### 6.2. エラーハンドリング

```swift
// ✅ 良い例
// do-catch：詳細なエラー処理が必要な場合
do {
    let tasks = try await firebaseService.fetchTasks()
    return .send(.tasksLoaded(tasks))
} catch let error as FirebaseError {
    return .send(.firebaseError(error))
} catch {
    return .send(.genericError(error))
}

// try?：エラーを無視できる場合
let cachedData = try? localCache.load()

// Result型：エラーを値として扱う場合
case .loadTasksResponse(.success(let tasks)):
    state.tasks = tasks
    state.isLoading = false
    return .none
    
case .loadTasksResponse(.failure(let error)):
    state.errorMessage = error.localizedDescription
    state.isLoading = false
    return .none
```

### 6.3. クロージャ

```swift
// ✅ 良い例：簡潔で読みやすい
let activeTask = tasks.filter { $0.isActive }
let taskNames = tasks.map(\.name)

// 複数行の場合は適切に改行
let processedTasks = tasks
    .filter { $0.isActive }
    .sorted { $0.priority > $1.priority }
    .map { TaskViewModel(task: $0) }

// ❌ 悪い例：不必要に冗長
let activeTasks = tasks.filter { (task) -> Bool in
    return task.isActive
}
```

### 6.4. 型定義

**Structを優先、必要に応じてClass**

```swift
// ✅ 良い例：値型（struct）を優先
struct TaskItem: Identifiable, Equatable {
    let id: UUID
    let title: String
    let isCompleted: Bool
}

// Classが必要な場合（参照セマンティクスが必要、ObservableObjectなど）
final class ShinAnimationController: ObservableObject {
    @Published var animationState: AnimationState = .idle
    
    // アニメーション制御の複雑な状態管理
}
```

**プロトコル指向プログラミング**

```swift
// ✅ 良い例
protocol TaskServiceProtocol {
    func fetchTasks() async throws -> [TaskItem]
    func updateTask(_ task: TaskItem) async throws
}

struct FirebaseTaskService: TaskServiceProtocol {
    // 実装
}

struct MockTaskService: TaskServiceProtocol {
    // テスト用実装
}
```

### 6.5. ジェネリクス

```swift
// ✅ 良い例：再利用可能なコンポーネント
struct LoadingState<T> {
    enum Status {
        case idle
        case loading
        case loaded(T)
        case failed(Error)
    }
    
    var status: Status = .idle
}

// 使用例
struct TaskListState {
    var tasksLoadingState: LoadingState<[TaskItem]> = .init()
    var shinsLoadingState: LoadingState<[ShinCharacter]> = .init()
}
```

### 6.6. 並行処理

**async/await中心の設計**

```swift
// ✅ 良い例
case .loadTasks:
    state.isLoading = true
    return .run { send in
        do {
            let tasks = try await dependencies.taskService.fetchTasks()
            await send(.tasksLoaded(tasks))
        } catch {
            await send(.loadTasksFailed(error))
        }
    }

// メインスレッドでのUI更新を明示
case .updateUI:
    return .run { send in
        await MainActor.run {
            // UI更新処理
        }
    }
```

## 7. SwiftUI固有の規約

### 7.1. Viewの構造

```swift
struct TaskListView: View {
    @Bindable var store: StoreOf<TaskReducer>

    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("タスク一覧")
                .onAppear {
                    store.send(.view(.onAppear))
                }
        }
    }

    // MARK: - Private Views

    @ViewBuilder
    private var contentView: some View {
        if store.isLoading {
            ProgressView("読み込み中...")
        } else if let errorMessage = store.error?.userFriendlyDescription {
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            Button("再試行") {
                store.send(.view(.onAppear))
            }
        } else {
            taskList
        }
    }

    @ViewBuilder
    private var taskList: some View {
        List(store.tasks) { task in
            TaskRowView(task: task)
                .onTapGesture {
                    store.send(.view(.taskItemTapped(task.id)))
                }
        }
        .refreshable {
            await store.send(.view(.onAppear), originatingFromPullToRefresh: true).finish()
        }
    }
}

// TaskRowViewの例 (簡略版)
struct TaskRowView: View {
    let task: TaskItem
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}
```

### 7.2. TCAとの連携

```swift
// ✅ 良い例：適切なscope使用
struct ParentView: View {
    @Bindable var store: StoreOf<AppFeature>

    var body: some View {
        VStack {
            // 子フィーチャーへのスコープ
            if store.showTaskFeature {
                TaskListView(
                    store: store.scope(
                        state: \.taskFeature,
                        action: \.child.taskFeature
                    )
                )
            }

            if store.showShinFeature {
                ShinCollectionView(
                    store: store.scope(
                        state: \.shinFeature,
                        action: \.child.shinFeature
                    )
                )
            }
        }
    }
}
```

## 8. TCA固有の規約

### 8.1. Actionの命名とペイロード

```swift
enum TaskFeatureAction {
    // UI イベント：動詞 + "Tapped/Pressed"
    case addTaskButtonTapped
    case taskItemTapped(TaskItem.ID)
    case deleteTaskButtonTapped(TaskItem.ID)
    
    // 非同期処理の開始：動詞
    case loadTasks
    case saveTask(TaskItem)
    
    // 非同期処理の結果：動詞 + "Response"
    case loadTasksResponse(Result<[TaskItem], Error>)
    case saveTaskResponse(Result<TaskItem, Error>)
    
    // 内部状態変更：動詞 + 対象
    case updateTaskCompletionStatus(TaskItem.ID, Bool)
    case resetErrorState
    
    // デリゲートアクション：名詞形
    case delegate(Delegate)
    
    enum Delegate {
        case taskCompleted(TaskItem)
        case taskDeleted(TaskItem.ID)
    }
}
```

### 8.2. Stateのプロパティ

```swift
@ObservableState
struct TaskFeatureState: Equatable, Sendable {
    // データプロパティ
    var tasks: [TaskItem] = []
    var selectedTaskId: TaskItem.ID?
    
    // UI状態プロパティ
    var isLoading: Bool = false
    var errorMessage: String?
    
    // ナビゲーション状態
    @PresentationState var destination: Destination.State?
    
    // 子フィーチャーの状態
    var taskDetail: TaskDetailFeature.State?
    
    @Reducer
    struct Destination: Sendable {
        @ObservableState
        enum State: Sendable {
            case alert(AlertState<Action.Alert>)
            case taskDetail(TaskDetailFeature.State)
        }
        
        enum Action: Sendable {
            case alert(Alert)
            case taskDetail(TaskDetailFeature.Action)
            
            enum Alert: Sendable {
                case confirmDelete
                case dismiss
            }
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.taskDetail, action: /Action.taskDetail) {
                TaskDetailFeature()
            }
        }
    }
}
```

### 8.3. Reducerの構造

```swift
@Reducer
struct TaskReducer { // StateとActionがSendableなら、通常Sendable準拠は不要
    @ObservableState
    struct State: Equatable, Sendable { /* ... */ }
    
    enum Action: Sendable { /* ... */ }
    
    @Dependency(\.taskService) var taskService
    @Dependency(\.uuid) var uuid
    @Dependency(\.date) var date
    
    var body: some ReducerOf<Self> {
        Reduce(core)
            .ifLet(\.$destination, action: /Action.destination) {
                Destination()
            }
    }
    
    // MARK: - Core Reducer
    
    private func core(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .viewAppeared:
            return .send(.loadTasks)
            
        case .loadTasks:
            state.isLoading = true
            return .run { send in
                do {
                    let tasks = try await taskService.fetchTasks()
                    await send(.loadTasksResponse(.success(tasks)))
                } catch {
                    await send(.loadTasksResponse(.failure(error)))
                }
            }
            
        case let .loadTasksResponse(.success(tasks)):
            state.isLoading = false
            state.tasks = tasks
            return .none
            
        case let .loadTasksResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
            return .none
            
        case .destination:
            return .none
        }
    }
}
```

### 8.4. フィーチャーのファイル構成

```
Sources/Features/TaskFeature/
├── TaskFeature.swift          // State, Action, Reducer
├── TaskFeatureView.swift      // SwiftUI View
├── TaskItem.swift             // Entity
└── TaskService.swift          // Service Protocol
```

## 9. エラーハンドリングパターン

### 9.1. エラータイプの定義

```swift
enum AppError: LocalizedError, Equatable {
    case network(NetworkError)
    case firebase(FirebaseError)
    case ai(AIError)
    case validation(ValidationError)
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .network(let error):
            return "ネットワークエラー: \(error.localizedDescription)"
        case .firebase(let error):
            return "データベースエラー: \(error.localizedDescription)"
        case .ai(let error):
            return "AI処理エラー: \(error.localizedDescription)"
        case .validation(let error):
            return "入力エラー: \(error.localizedDescription)"
        case .unknown(let message):
            return "予期しないエラー: \(message)"
        }
    }
}
```

### 9.2. エラー処理パターン

```swift
// TCAでのエラーハンドリング
case let .saveTaskResponse(.failure(error)):
    state.isLoading = false
    state.destination = .alert(
        AlertState {
            TextState("エラー")
        } actions: {
            ButtonState(action: .confirmRetry) {
                TextState("再試行")
            }
            ButtonState(role: .cancel, action: .dismiss) {
                TextState("キャンセル")
            }
        } message: {
            TextState(error.localizedDescription)
        }
    )
    return .none
```

## 10. ログ出力戦略

### 10.1. ログレベル

```swift
enum LogLevel: String, CaseIterable {
    case debug = "DEBUG"
    case info = "INFO" 
    case warning = "WARNING"
    case error = "ERROR"
}
```

### 10.2. ログ出力方針

```swift
// TCAのReducer内でのログ出力例
case .loadTasks:
    logger.info("タスク読み込み開始")
    state.isLoading = true
    return .run { send in
        do {
            let tasks = try await taskService.fetchTasks()
            logger.info("タスク読み込み成功: \(tasks.count)件")
            await send(.loadTasksResponse(.success(tasks)))
        } catch {
            logger.error("タスク読み込み失敗: \(error)")
            await send(.loadTasksResponse(.failure(error)))
        }
    }
```

## 11. 利用ツール

### 11.1. SwiftLint

**`.swiftlint.yml`設定例:**

```yaml
# 有効にするルール
opt_in_rules:
  - array_init
  - closure_spacing
  - empty_count
  - explicit_init
  - file_name
  - first_where
  - force_unwrapping
  - implicitly_unwrapped_optional
  - overridden_super_call
  - private_outlet
  - redundant_nil_coalescing
  - vertical_whitespace_closing_braces

# 無効にするルール
disabled_rules:
  - trailing_whitespace

# カスタムルール設定
line_length: 120
function_body_length: 50
type_body_length: 300

# 除外ディレクトリ
excluded:
  - Packages
  - .build
```

### 11.2. SwiftFormat

プロジェクトルートに`.swiftformat`ファイルを配置し、継続的なフォーマット統一を行います。

---

**更新履歴:**
- 2024-12: 初版作成

**関連ドキュメント:**
- [`docs/02_ARCHITECTURE.md`](./02_ARCHITECTURE.md): アーキテクチャ設計書
- [`docs/07_AI_AGENT_CODING_GUIDELINES.md`](./07_AI_AGENT_CODING_GUIDELINES.md): AIエージェント利用ガイドライン 
