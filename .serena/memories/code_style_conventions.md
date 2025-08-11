# コードスタイル・規約

## Ruby/Railsスタイル

### Linting・フォーマット
- **Rubocop**: rubocop-rails-omakase使用
  - Rails公式のOmakaseスタイルガイドに準拠
  - 設定ファイル: `.rubocop.yml`

### Ruby版本
- **Ruby**: 3.4.3 (`.ruby-version`で管理)

### テストフレームワーク
- **RSpec**: テストフレームワーク
  - `rspec-rails` gem使用
  - Factory Bot for fixtures
  - テストファイル場所: `spec/`

### セキュリティ
- **Brakeman**: セキュリティ脆弱性の静的解析

### その他の規約
- **コメント**: 日本語での記述が前提
- **API設計**: RESTful API (`/api/v1/`プレフィックス)
- **認証**: JWT認証方式
- **CORS**: フロントエンドとの連携用設定済み

### データベース
- **PostgreSQL**使用
- Active Recordでのマイグレーション管理

### 環境設定
- **dotenv-rails**: 環境変数管理
- 本番環境用のDocker設定有り