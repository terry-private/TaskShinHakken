# 05 UI/UXガイドライン - タスクしん発見！

## 1. はじめに

このドキュメントは、タスクしん発見！アプリにおけるUI/UXデザインの指針を定めます。Apple Human Interface Guidelines (HIG) を基盤としつつ、本アプリ固有の「和風ファンタジー」テーマと子供向けアプリとしての特性を考慮した、一貫性があり魅力的なユーザー体験を提供するためのガイドラインです。

**このガイドラインの目的:**
- 一貫したデザイン体験の提供
- アクセシビリティの確保
- 子供と保護者の両方にとって使いやすいインターフェースの実現
- 「発見と成長」を促すワクワクする体験設計
- 開発効率の向上とデザインシステムの確立

## 2. コアUI/UX原則

### 2.1. 基本原則

1. **子供にとって楽しく直感的**
   - 操作に迷わないシンプルな導線
   - 即座のフィードバックと分かりやすいアニメーション
   - 色やアイコンによる視覚的な分類

2. **保護者にとって分かりやすく安心**
   - 必要な情報へ素早くアクセス可能
   - 子供の進捗が一目で分かる
   - プライバシーとセキュリティへの配慮

3. **発見と成長を促す**
   - 「しん」との出会いや成長の瞬間を特別に演出
   - 達成感を高める視覚的フィードバック
   - 継続的な利用を促す魅力的なインタラクション

4. **和風ファンタジーの世界観を一貫して表現**
   - 温かみのある自然な色合い
   - 日本の伝統文化を感じさせるデザイン要素
   - 現代的でありながら落ち着いた雰囲気

5. **アクセシビリティへの配慮**
   - 多様なユーザーが利用できるインクルーシブデザイン
   - 年齢や能力に関わらずアクセス可能

### 2.2. ユーザー体験の原則

**子供向けUX:**
- **大きなタップターゲット** (最小44pt x 44pt)
- **明確な状態表示** (進行中/完了/未開始)
- **楽しいアニメーションとサウンド**
- **エラー耐性** (誤操作からの簡単な復帰)

**保護者向けUX:**
- **効率的な情報表示** (ダッシュボード形式)
- **詳細な設定オプション**
- **安全で分かりやすい子供管理機能**
- **プログレストラッキング** (成長の可視化)

## 3. Apple Human Interface Guidelines (HIG) の遵守

### 3.1. HIG準拠の重要性

本アプリは **Apple Human Interface Guidelines** を基本として設計します。これにより、ユーザーが慣れ親しんだiOSの操作感を保ちつつ、アプリ固有の体験を提供します。

**Apple HIG公式リンク:**
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios)
- [iPadOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ipados)

### 3.2. 重視するHIG項目

**ナビゲーション:**
- Clear and predictable navigation patterns
- 適切なナビゲーションバーとタブバーの使用
- モーダルの適切な利用（重要な操作時のみ）

**フィードバック:**
- ユーザーアクションに対する即座のレスポンス
- ローディング状態の明確な表示
- 成功/エラー状態の分かりやすい通知

**データ入力:**
- 年齢に応じた入力方法の選択
- 保護者向けには効率的な一括操作
- 子供向けには簡単で楽しい入力体験

**子供向けアプリ特有の配慮:**
- [Designing for Children and Parental Approval](https://developer.apple.com/design/human-interface-guidelines/designing-for-children)
- プライバシー保護とペアレンタルコントロール
- 年齢に適したコンテンツとインタラクション

## 4. ビジュアルデザイン (テーマ: 和風ファンタジー)

### 4.1. カラーパレット

**プライマリカラー (Primary Colors):**
```swift
enum AppColors {
    // メインブランドカラー
    static let shinGreen = Color(red: 0.4, green: 0.7, blue: 0.5)      // #66B366 - 「しん」のメインカラー
    static let sakuraPink = Color(red: 0.9, green: 0.7, blue: 0.8)     // #E6B3CC - 桜のような温かいピンク
    
    // セカンダリカラー
    static let tatamiBrown = Color(red: 0.8, green: 0.7, blue: 0.5)    // #CCB380 - 畳の落ち着いた茶色
    static let skyBlue = Color(red: 0.7, green: 0.85, blue: 0.95)      // #B3D9F2 - 空のような青
}
```

**機能的カラー (Functional Colors):**
```swift
extension AppColors {
    // ステータスカラー
    static let taskCompleted = Color.green                              // タスク完了
    static let taskInProgress = Color.orange                           // タスク実行中
    static let taskNotStarted = Color.gray                             // タスク未開始
    
    // UI要素カラー
    static let backgroundPrimary = Color(.systemBackground)            // メイン背景
    static let backgroundSecondary = Color(.secondarySystemBackground) // セカンダリ背景
    static let textPrimary = Color(.label)                             // メインテキスト
    static let textSecondary = Color(.secondaryLabel)                  // セカンダリテキスト
    
    // 警告・エラー
    static let warningYellow = Color.yellow                            // 警告
    static let errorRed = Color.red                                    // エラー
}
```

### 4.2. タイポグラフィ

**フォント階層:**
```swift
enum AppFonts {
    // 日本語対応フォント
    case title1         // 28pt - Bold - 画面タイトル
    case title2         // 22pt - Bold - セクションタイトル
    case headline       // 18pt - Semibold - 重要な見出し
    case body           // 16pt - Regular - 本文
    case callout        // 15pt - Regular - キャプション
    case footnote       // 13pt - Regular - 注釈
    
    var font: Font {
        switch self {
        case .title1:
            return .title.bold()
        case .title2:
            return .title2.bold()
        case .headline:
            return .headline.weight(.semibold)
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        }
    }
}
```

**読みやすさの配慮:**
- **Dynamic Type対応**: 全てのテキストでユーザーの文字サイズ設定に対応
- **十分なコントラスト**: WCAG AA準拠のコントラスト比（4.5:1以上）
- **適切な行間**: 読みやすさを考慮した行間設定

### 4.3. アイコンシステム

**SF Symbols活用:**
```swift
enum AppIcons {
    // タスク関連
    case taskList = "list.bullet"
    case taskCompleted = "checkmark.circle.fill"
    case taskInProgress = "clock.fill"
    
    // 「しん」関連
    case shinCharacter = "sparkles"
    case shinCollection = "square.grid.3x3"
    case shinGrowth = "arrow.up.circle"
    
    // ナビゲーション
    case home = "house.fill"
    case profile = "person.circle"
    case settings = "gearshape.fill"
    
    var systemName: String {
        return self.rawValue
    }
}
```

**カスタムアイコン指針:**
- 「しん」キャラクター: 24x24pt, 32x32ptの複数サイズ
- 一貫したライン幅とスタイル
- 和風モチーフの取り入れ（控えめに）

### 4.4. イラスト・画像スタイル

**「しん」キャラクターデザイン:**
- **基本スタイル**: 丸みを帯びた親しみやすいフォルム
- **カラーパレット**: 自然な色合い（緑、茶、クリーム等）
- **表情**: 豊かで感情的な表現
- **サイズバリエーション**: 小(32pt), 中(64pt), 大(128pt)

**背景・装飾要素:**
- **テクスチャ**: 和紙、木目調の控えめなテクスチャ
- **パターン**: 伝統的な幾何学模様の現代的アレンジ
- **グラデーション**: 自然な色の遷移

## 5. UIコンポーネントライブラリ

### 5.1. ボタンコンポーネント

```swift
struct AppButton: View {
    enum Style {
        case primary    // メインアクション
        case secondary  // サブアクション
        case text       // テキストのみ
        case shin       // 「しん」関連の特別なボタン
    }
    
    let title: String
    let style: Style
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFonts.callout.font)
                .foregroundColor(foregroundColor)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(backgroundColor)
                .cornerRadius(12)
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return AppColors.shinGreen
        case .secondary:
            return AppColors.backgroundSecondary
        case .text:
            return Color.clear
        case .shin:
            return AppColors.sakuraPink
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .shin:
            return Color.white
        case .secondary, .text:
            return AppColors.textPrimary
        }
    }
}
```

### 5.2. タスクカードコンポーネント

```swift
struct TaskCard: View {
    let task: TaskItem
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    // 「しん」アイコン
                    if !task.associatedShinTypes.isEmpty {
                        Image(systemName: AppIcons.shinCharacter.systemName)
                            .foregroundColor(AppColors.shinGreen)
                    }
                    
                    Text(task.title)
                        .font(AppFonts.headline.font)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Spacer()
                    
                    // ステータスアイコン
                    statusIcon
                }
                
                if let description = task.description {
                    Text(description)
                        .font(AppFonts.body.font)
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(2)
                }
                
                HStack {
                    Label("\(task.pointsReward)pt", systemImage: "star.fill")
                        .font(AppFonts.footnote.font)
                        .foregroundColor(AppColors.shinGreen)
                    
                    Spacer()
                    
                    if let dueDate = task.dueDate {
                        Text(dueDate, style: .date)
                            .font(AppFonts.footnote.font)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
            }
            .padding(16)
            .background(AppColors.backgroundPrimary)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private var statusIcon: some View {
        switch task.status {
        case .completed:
            Image(systemName: AppIcons.taskCompleted.systemName)
                .foregroundColor(AppColors.taskCompleted)
        case .inProgress:
            Image(systemName: AppIcons.taskInProgress.systemName)
                .foregroundColor(AppColors.taskInProgress)
        default:
            Circle()
                .fill(AppColors.taskNotStarted)
                .frame(width: 20, height: 20)
        }
    }
}
```

### 5.3. 「しん」表示コンポーネント

```swift
struct ShinCharacterView: View {
    let shin: ShinCharacter
    let size: ShinSize
    let showGrowthAnimation: Bool = false
    
    enum ShinSize {
        case small  // 32pt
        case medium // 64pt
        case large  // 128pt
        
        var dimension: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 64
            case .large: return 128
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // 「しん」キャラクター画像
                AsyncImage(url: shin.imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(AppColors.backgroundSecondary)
                        .overlay(
                            Image(systemName: AppIcons.shinCharacter.systemName)
                                .foregroundColor(AppColors.textSecondary)
                        )
                }
                .frame(width: size.dimension, height: size.dimension)
                .cornerRadius(size.dimension / 8)
                
                // 成長アニメーション
                if showGrowthAnimation {
                    Circle()
                        .stroke(AppColors.shinGreen, lineWidth: 2)
                        .scaleEffect(showGrowthAnimation ? 1.5 : 1.0)
                        .opacity(showGrowthAnimation ? 0 : 1)
                        .animation(.easeOut(duration: 1.0), value: showGrowthAnimation)
                }
            }
            
            if size != .small {
                VStack(spacing: 4) {
                    Text(shin.name)
                        .font(AppFonts.callout.font)
                        .foregroundColor(AppColors.textPrimary)
                    
                    if size == .large {
                        Text("Lv.\(shin.level)")
                            .font(AppFonts.footnote.font)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
            }
        }
    }
}
```

## 6. インタラクションデザインとアニメーション

### 6.1. 基本アニメーション原則

**タイミング関数:**
```swift
extension Animation {
    // 標準アニメーション
    static let appDefault = Animation.easeInOut(duration: 0.3)
    static let appQuick = Animation.easeInOut(duration: 0.15)
    static let appSlow = Animation.easeInOut(duration: 0.6)
    
    // 特別なアニメーション
    static let shinDiscovery = Animation.spring(response: 0.8, dampingFraction: 0.6)
    static let taskCompletion = Animation.easeOut(duration: 0.5)
}
```

### 6.2. 重要な瞬間の演出

**「しん」発見アニメーション:**
```swift
struct ShinDiscoveryAnimation: View {
    @State private var showDiscovery = false
    @State private var scale: CGFloat = 0.1
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            // 背景エフェクト
            Circle()
                .fill(AppColors.shinGreen.opacity(0.3))
                .scaleEffect(showDiscovery ? 2.0 : 0.1)
                .opacity(showDiscovery ? 0 : 1)
            
            // 「しん」キャラクター
            ShinCharacterView(shin: discoveredShin, size: .large)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
        }
        .onAppear {
            withAnimation(.shinDiscovery) {
                showDiscovery = true
                scale = 1.0
            }
            
            withAnimation(.linear(duration: 0.5).delay(0.2)) {
                rotation = 360
            }
        }
    }
}
```

**タスク完了フィードバック:**
```swift
struct TaskCompletionFeedback: View {
    @State private var showCheckmark = false
    @State private var showParticles = false
    
    var body: some View {
        ZStack {
            // チェックマークアニメーション
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(AppColors.taskCompleted)
                .scaleEffect(showCheckmark ? 1.0 : 0.1)
                .opacity(showCheckmark ? 1 : 0)
            
            // パーティクルエフェクト
            ForEach(0..<6, id: \.self) { index in
                Circle()
                    .fill(AppColors.shinGreen)
                    .frame(width: 8, height: 8)
                    .offset(particleOffset(for: index))
                    .opacity(showParticles ? 0 : 1)
            }
        }
        .onAppear {
            withAnimation(.taskCompletion) {
                showCheckmark = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(0.3)) {
                showParticles = true
            }
        }
    }
    
    private func particleOffset(for index: Int) -> CGSize {
        let angle = Double(index) * 60.0 * .pi / 180
        let radius: CGFloat = showParticles ? 60 : 0
        return CGSize(
            width: cos(angle) * radius,
            height: sin(angle) * radius
        )
    }
}
```

### 6.3. サウンドデザイン

**効果音の分類:**
```swift
enum AppSounds {
    case taskCompleted      // タスク完了時
    case shinDiscovered     // 「しん」発見時
    case shinLevelUp        // 「しん」レベルアップ
    case buttonTap          // ボタンタップ
    case achievement        // 実績解除
    
    var fileName: String {
        switch self {
        case .taskCompleted: return "task_completed.wav"
        case .shinDiscovered: return "shin_discovered.wav"
        case .shinLevelUp: return "shin_levelup.wav"
        case .buttonTap: return "button_tap.wav"
        case .achievement: return "achievement.wav"
        }
    }
}
```

### 6.4. 触覚フィードバック (Haptics)

```swift
enum AppHaptics {
    case light      // 軽いタップ
    case medium     // 通常のフィードバック
    case heavy      // 重要なアクション
    case success    // 成功時
    case warning    // 警告時
    case error      // エラー時
    
    func trigger() {
        switch self {
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
```

## 7. アクセシビリティ (A11y)

### 7.1. アクセシビリティコミットメント

本アプリは、全てのユーザーが平等にアクセスできることを重視し、以下のアクセシビリティ機能を積極的に実装します：

- **VoiceOver対応**
- **Dynamic Type対応**
- **High Contrast対応**
- **Switch Control対応**
- **Reduced Motion対応**

### 7.2. 実装指針

**VoiceOver対応:**
```swift
struct AccessibleTaskCard: View {
    let task: TaskItem
    
    var body: some View {
        TaskCard(task: task) {
            // タップアクション
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("タスクの詳細を表示します")
        .accessibilityAddTraits(.isButton)
    }
    
    private var accessibilityLabel: String {
        var label = "タスク: \(task.title)"
        
        switch task.status {
        case .completed:
            label += ", 完了済み"
        case .inProgress:
            label += ", 実行中"
        case .notStarted:
            label += ", 未開始"
        }
        
        label += ", \(task.pointsReward)ポイント"
        
        return label
    }
}
```

**Dynamic Type対応:**
```swift
struct ScalableText: View {
    let text: String
    let style: AppFonts
    
    var body: some View {
        Text(text)
            .font(style.font)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}
```

**Reduced Motion対応:**
```swift
struct MotionSensitiveAnimation: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var body: some View {
        ShinCharacterView(shin: shin, size: .medium)
            .scaleEffect(isActive ? 1.1 : 1.0)
            .animation(
                reduceMotion ? nil : .appDefault,
                value: isActive
            )
    }
}
```

## 8. プラットフォーム間の考慮事項

### 8.1. iPhone vs iPad対応

**iPhone (Compact):**
- シングルカラムレイアウト
- タブベースナビゲーション
- より大きなタップターゲット

**iPad (Regular):**
- マルチカラムレイアウト
- サイドバーナビゲーション
- 詳細な情報表示

```swift
struct AdaptiveLayout: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            CompactLayout()
        } else {
            RegularLayout()
        }
    }
}
```

### 8.2. ダークモード対応

```swift
extension AppColors {
    static let backgroundPrimary = Color(.systemBackground)
    static let backgroundSecondary = Color(.secondarySystemBackground)
    static let textPrimary = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
}
```

## 9. デザインツールとアセット管理

### 9.1. 推奨デザインツール

**主要ツール:**
- **Figma**: UIデザイン、プロトタイピング、デザインシステム管理
- **SF Symbols app**: Apple純正アイコンの確認・カスタマイズ
- **Xcode**: Asset Catalog管理、実機プレビュー

### 9.2. アセット命名規則

**画像アセット:**
```
// 基本形式: [category]_[name]_[variant]_[size]
shin_character_okatazuke_happy_64pt
shin_character_benkyou_normal_32pt
task_icon_study_default
background_pattern_washi_light
```

**カラーアセット:**
```
// Color Set名
AppShinGreen
AppSakuraPink
AppTatamiBrown
TaskCompleted
TaskInProgress
```

**アイコンアセット:**
```
// SF Symbols使用時
IconTaskList           // list.bullet
IconShinCharacter      // sparkles
IconHome              // house.fill

// カスタムアイコン
icon_custom_shin_collection
icon_custom_family_tree
```

---

**更新履歴:**
- 2024-12: 初版作成

**関連ドキュメント:**
- [`docs/01_REQUIREMENTS.md`](./01_REQUIREMENTS.md): 要件定義書
- [`docs/02_ARCHITECTURE.md`](./02_ARCHITECTURE.md): アーキテクチャ設計書
- [`docs/03_CODING_CONVENTIONS.md`](./03_CODING_CONVENTIONS.md): コーディング規約 
