# アセットディレクトリ構成

このディレクトリは、アプリで使用するデザインアセットや開発支援ファイルを管理します。

## フォルダ構成

```
assets/
├── images/           # 画像ファイル
│   ├── shin/         # 「しん」キャラクター画像
│   ├── icons/        # カスタムアイコン
│   ├── backgrounds/  # 背景画像
│   └── ui/           # UI要素
├── sounds/           # 効果音・BGM
│   ├── effects/      # 効果音
│   └── ambient/      # 環境音・BGM
└── fonts/            # カスタムフォント
```

## ファイル命名規則

### 画像ファイル
- **形式**: `[category]_[name]_[variant]_[size].png`
- **例**: 
  - `shin_okatazuke_happy_64pt.png`
  - `icon_task_completed.png`
  - `bg_home_light.png`

### 音声ファイル
- **形式**: `[category]_[name].wav`
- **例**:
  - `effect_task_completed.wav`
  - `effect_shin_discovered.wav`
  - `ambient_home_background.wav`

### フォント
- **形式**: `[FontName]-[Weight].ttf`
- **例**: `NotoSansJP-Regular.ttf`

## Xcode Integration

これらのアセットはXcodeプロジェクトのAsset Catalogに統合されます：
- `TaskShinHakken.Product/Assets.xcassets/`

## 使用方法

### Swift コード内での参照
```swift
// 画像
Image("shin_okatazuke_happy")

// 色
Color("AppShinGreen")

// サウンド  
AudioServicesPlaySystemSound(soundID)
```

詳細は [`docs/05_UI_UX_GUIDELINES.md`](../docs/05_UI_UX_GUIDELINES.md) を参照してください。 