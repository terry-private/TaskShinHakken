# 02_PROJECT_OVERVIEW.md - プロジェクト概要とドキュメント案内

## 1. はじめに (Introduction)

このドキュメントは、子供向けタスク管理アプリ「タスクしん発見！」プロジェクトの全体像を把握し、関連する主要ドキュメントへアクセスするための出発点です。

本アプリの詳細な要件（目的、ターゲットユーザー、機能、開発方針など）については、包括的な定義書である [`01_REQUIREMENTS.md`](./01_REQUIREMENTS.md) を最優先の参照資料としてください。

この `02_PROJECT_OVERVIEW.md` は、開発者自身（あなた）およびAI開発エージェントが、プロジェクトの全体構造とドキュメント体系を理解するための一助となることを目的としています。

## 2. 開発体制とアプローチ (Development Model and Approach)

本プロジェクト「タスクしん発見！」は、以下の体制とアプローチで開発を進めます。

- **開発主体:** [あなたのお名前またはハンドルネーム]
- **主要なコーディング支援:** AI開発エージェント
- **開発プロセス:**
    - AIエージェントによって生成されたコードや成果物は、人間（あなた）がレビュー、テスト、および統合を行います。
    - 開発は [`01_REQUIREMENTS.md`](./01_REQUIREMENTS.md#9-開発方針) に記載の通り、MVP（Minimum Viable Product）アプローチを採用し、段階的に機能拡張を行います。
    - AIエージェントとの効果的な協調作業については、[`08_AI_AGENT_CODING_GUIDELINES.md`](./08_AI_AGENT_CODING_GUIDELINES.md) を参照してください。

## 3. 主要ドキュメント構成 (Key Documentation Structure)

本プロジェクトの主要なドキュメントは `docs/` ディレクトリに格納されており、それぞれの目的は以下の通りです。

- **[`01_REQUIREMENTS.md`](./01_REQUIREMENTS.md): 要件定義書**
    - このプロジェクトで「何を」作るのか、アプリの目的、機能、ターゲットユーザー、開発スコープなどを包括的に定義しています。**最重要ドキュメント**です。
- **[`02_PROJECT_OVERVIEW.md`](./02_PROJECT_OVERVIEW.md): プロジェクト概要とドキュメント案内 (このドキュメント)**
    - プロジェクト全体の高レベルなコンテキストと、各ドキュメントへの案内を提供します。
- **[`03_ARCHITECTURE.md`](./03_ARCHITECTURE.md): アーキテクチャ設計書**
    - 採用するソフトウェアアーキテクチャ（TCA）、主要コンポーネント、設計パターン、技術的な意思決定などを記述します。「どのように」作るかの技術的な青写真です。
- **[`04_CODING_CONVENTIONS.md`](./04_CODING_CONVENTIONS.md): コーディング規約**
    - Swiftのコーディングスタイル、命名規則、フォーマット、コメント規約など、コードの一貫性を保つための規約を定めます。
- **[`05_BACKEND_INTEGRATION_GUIDELINES.md`](./05_BACKEND_INTEGRATION_GUIDELINES.md): バックエンド連携ガイドライン**
    - Firebase (Authentication, Firestore, Functions等) の利用方針、データモデリング、セキュリティルールなど、バックエンドサービスとの連携に関する規約と指針を記述します。
- **[`06_UI_UX_GUIDELINES.md`](./06_UI_UX_GUIDELINES.md): UI/UXガイドライン**
    - Apple Human Interface Guidelines (HIG) の遵守事項に加え、本アプリ固有のUI/UX原則、カラースキーム、タイポグラフィ、再利用可能なUIコンポーネントの指針などを記述します。
- **[`07_DEVELOPMENT_PROCESS.md`](./07_DEVELOPMENT_PROCESS.md): 開発プロセス規約**
    - バージョン管理戦略（ブランチ戦略）、Issueトラッキング、Pull Requestの運用フロー、コードレビュープロセス、テスト戦略など、日々の開発の進め方に関する規約を定めます。
- **[`08_AI_AGENT_CODING_GUIDELINES.md`](./08_AI_AGENT_CODING_GUIDELINES.md): AIエージェント利用ガイドライン**
    - AI開発エージェントへの指示の出し方、期待する成果物の形式、レビューのポイント、AIの学習バージョン管理など、AIとの協調作業を円滑に進めるための具体的な指針を記述します。

## 4. 現在のプロジェクトステータス (Current Project Status)
- （ここに現在の開発フェーズやマイルストーン、短期的な目標などを記述します）

## 5. 連絡先・質問窓口 (Contact / Questions)
- プロジェクトに関する主要な意思決定や質問は、[あなたのお名前またはハンドルネーム] が担当します。