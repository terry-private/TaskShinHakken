# タスクしん発見！

## 1. 概要 (Overview)

「タスクしん発見！」は、子供たちが日々のタスク（お勉強、お手伝い、お片付けなど）を、まるで冒険のように楽しく主体的にこなせるようになることを目指す、AIサポート付きのiOS/iPadOS向けタスク管理アプリです。日本の「八百万の神」の考え方を取り入れたユニークなキャラクター「〇〇しん」たちとの出会いや成長を通じて、子供たちの頑張りを可視化し、モチベーション向上をサポートします。

より詳細なアプリのコンセプト、機能、ターゲットユーザー、開発方針については、以下の要件定義書をご覧ください。このドキュメントはプロジェクトの最も基本的な定義となります。

- **[最重要] [`docs/01_REQUIREMENTS.md`](./docs/01_REQUIREMENTS.md): 要件定義書**

## 2. 開発体制とアプローチ (Development Model and Approach)

本プロジェクトは、以下の体制とアプローチで開発を進めます。

- **開発主体:** [あなたのお名前またはハンドルネームをここに入力してください]
- **主要なコーディング支援:** AI開発エージェント
- **開発プロセス:**
    - AIエージェントによって生成されたコードや成果物は、人間（開発主体）がレビュー、テスト、および統合を行います。
    - 開発は [`docs/01_REQUIREMENTS.md`](./docs/01_REQUIREMENTS.md#9-開発方針) に記載の通り、MVP（Minimum Viable Product）アプローチを採用し、段階的に機能拡張を行います。
    - AIエージェントとの効果的な協調作業については、[`docs/07_AI_AGENT_CODING_GUIDELINES.md`](./docs/07_AI_AGENT_CODING_GUIDELINES.md) を参照してください。

## 3. 主要ドキュメント構成 (Key Documentation Structure)

本プロジェクトの主要なドキュメントは `docs/` ディレクトリに格納されており、それぞれ以下の目的を持っています。プロジェクト理解や開発を進める上での重要な情報源となります。

- [`docs/01_REQUIREMENTS.md`](./docs/01_REQUIREMENTS.md): **要件定義書**
  - このプロジェクトで「何を」作るのか、アプリの目的、機能、ターゲットユーザー、開発スコープなどを包括的に定義しています。**プロジェクトの最重要ドキュメント**です。
- [`docs/02_ARCHITECTURE.md`](./docs/02_ARCHITECTURE.md): **アーキテクチャ設計書**
  - 採用するソフトウェアアーキテクチャ（TCA）、主要コンポーネント、設計パターン、技術的な意思決定などを記述します。「どのように」作るかの技術的な青写真です。
- [`docs/03_CODING_CONVENTIONS.md`](./docs/03_CODING_CONVENTIONS.md): **コーディング規約**
  - Swiftのコーディングスタイル、命名規則、フォーマット、コメント規約など、コードの一貫性を保つための規約を定めます。
- [`docs/04_BACKEND_INTEGRATION_GUIDELINES.md`](./docs/04_BACKEND_INTEGRATION_GUIDELINES.md): **バックエンド連携ガイドライン**
  - Firebase (Authentication, Firestore, Functions等) の利用方針、データモデリング、セキュリティルールなど、バックエンドサービスとの連携に関する規約と指針を記述します。
- [`docs/05_UI_UX_GUIDELINES.md`](./docs/05_UI_UX_GUIDELINES.md): **UI/UXガイドライン**
  - Apple Human Interface Guidelines (HIG) の遵守事項に加え、本アプリ固有のUI/UX原則、カラースキーム、タイポグラフィ、再利用可能なUIコンポーネントの指針などを記述します。
- [`docs/06_DEVELOPMENT_PROCESS.md`](./docs/06_DEVELOPMENT_PROCESS.md): **開発プロセス規約**
  - バージョン管理戦略（ブランチ戦略）、Issueトラッキング、Pull Requestの運用フロー、コードレビュープロセス、テスト戦略など、日々の開発の進め方に関する規約を定めます。
- [`docs/07_AI_AGENT_CODING_GUIDELINES.md`](./docs/07_AI_AGENT_CODING_GUIDELINES.md): **AIエージェント利用ガイドライン**
  - AI開発エージェントへの指示の出し方、期待する成果物の形式、レビューのポイント、AIの学習バージョン管理など、AIとの協調作業を円滑に進めるための具体的な指針を記述します。

## 4. セットアップ方法 (Setup Instructions)

(TBD: 詳細を記述してください)

## 5. ビルドと実行 (Build and Run)

(TBD: 詳細を記述してください)

## 6. テスト (Testing)

(TBD: 詳細を記述してください)

## 7. ライセンス (License)

(TBD: ライセンスを決定し記述してください)

---