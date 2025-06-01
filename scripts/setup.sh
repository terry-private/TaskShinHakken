#!/bin/bash

# TaskShinHakken 開発環境セットアップスクリプト
# このスクリプトは開発に必要なツールのインストールと設定を行います

set -e

echo "🌟 タスクしん発見！開発環境セットアップを開始します..."

# Homebrew がインストールされているかチェック
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrewがインストールされていません"
    echo "Homebrewをインストールしてから再実行してください："
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "✅ Homebrew が見つかりました"

# SwiftLint のインストール
echo "📝 SwiftLint をインストール中..."
if ! command -v swiftlint &> /dev/null; then
    brew install swiftlint
    echo "✅ SwiftLint をインストールしました"
else
    echo "✅ SwiftLint は既にインストールされています"
fi

# SwiftFormat のインストール
echo "🎨 SwiftFormat をインストール中..."
if ! command -v swiftformat &> /dev/null; then
    brew install swiftformat
    echo "✅ SwiftFormat をインストールしました"
else
    echo "✅ SwiftFormat は既にインストールされています"
fi

# Firebase CLI のインストール（オプション）
echo "🔥 Firebase CLI をインストール中..."
if ! command -v firebase &> /dev/null; then
    curl -sL https://firebase.tools | bash
    echo "✅ Firebase CLI をインストールしました"
else
    echo "✅ Firebase CLI は既にインストールされています"
fi

# Git hooks の設定
echo "🪝 Git hooks を設定中..."
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# SwiftLint pre-commit hook

if which swiftlint >/dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
EOF

chmod +x .git/hooks/pre-commit
echo "✅ Git pre-commit hook を設定しました"

# .swiftlint.yml の作成
echo "📋 SwiftLint 設定ファイルを作成中..."
cat > .swiftlint.yml << 'EOF'
# SwiftLint Configuration for TaskShinHakken

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
  - TaskShinHakken.Product/TaskShinHakken.Product.xcodeproj
EOF

echo "✅ SwiftLint 設定ファイルを作成しました"

# .swiftformat の作成
echo "🎨 SwiftFormat 設定ファイルを作成中..."
cat > .swiftformat << 'EOF'
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
EOF

echo "✅ SwiftFormat 設定ファイルを作成しました"

echo ""
echo "🎉 セットアップが完了しました！"
echo ""
echo "次のステップ："
echo "1. Xcode で TaskShinHakken.xcworkspace を開く"
echo "2. Simulator でプロジェクトをビルド・実行"
echo "3. 'docs/' フォルダのドキュメントを確認"
echo ""
echo "開発の際は以下のコマンドが利用できます："
echo "- ./scripts/lint.sh      # SwiftLint 実行"
echo "- ./scripts/format.sh    # SwiftFormat 実行"
echo "- ./scripts/test.sh      # テスト実行"
echo ""
echo "楽しい開発をお祈りしています！ 🌟" 