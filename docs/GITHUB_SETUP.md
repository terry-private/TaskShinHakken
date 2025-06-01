# GitHub リポジトリ追加設定手順

Issue #1 の一環として、GitHub上で手動で行う追加設定について説明します。

## 1. ブランチ保護設定

### main ブランチの保護

1. GitHubリポジトリページで **Settings** タブを開く
2. 左サイドバーから **Branches** を選択
3. **Add rule** をクリック
4. 以下の設定を行う：

**Branch name pattern**: `main`

**保護設定**:
- ☑️ Require a pull request before merging
  - ☑️ Require approvals (1名以上)
  - ☑️ Dismiss stale PR approvals when new commits are pushed
- ☑️ Require status checks to pass before merging
  - ☑️ Require branches to be up to date before merging
- ☑️ Require linear history
- ☑️ Include administrators

### develop ブランチの保護

同様に `develop` ブランチに対しても設定：

**Branch name pattern**: `develop`

**保護設定**:
- ☑️ Require a pull request before merging
  - ☑️ Require approvals (1名以上)
- ☑️ Require status checks to pass before merging

---

**関連ドキュメント:**
- [`docs/06_DEVELOPMENT_PROCESS.md`](./06_DEVELOPMENT_PROCESS.md): 開発プロセス詳細 