# 開発支援スクリプト

このディレクトリには、開発作業を効率化するためのスクリプトが含まれています。

## 予定されるスクリプト

### ビルド・テスト自動化
- `build.sh` - プロジェクトのビルドスクリプト
- `test.sh` - ユニットテスト実行スクリプト
- `lint.sh` - SwiftLint実行スクリプト

### デプロイメント
- `archive.sh` - App Store用アーカイブ作成
- `export.sh` - IPA出力スクリプト

### 開発支援
- `setup.sh` - 初期環境セットアップ
- `clean.sh` - ビルドキャッシュクリア
- `version_bump.sh` - バージョン番号更新

## 使用方法

各スクリプトは実行可能にして使用します：

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

詳細は各スクリプトのヘッダーコメントを参照してください。 