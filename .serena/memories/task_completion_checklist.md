# タスク完了時のチェックリスト

## コード変更後に必ず実行すること

### 1. コード品質チェック
```bash
# Rubocop（スタイルチェック）
bundle exec rubocop

# 自動修正可能な場合
bundle exec rubocop -a
```

### 2. セキュリティチェック
```bash
# Brakeman（セキュリティ脆弱性チェック）
bundle exec brakeman
```

### 3. テスト実行
```bash
# 全テスト実行
bundle exec rspec

# 変更に関連するテストのみ（推奨）
bundle exec rspec spec/path/to/related_spec.rb
```

### 4. データベース確認
変更がモデルやマイグレーションに関わる場合：
```bash
# マイグレーション状態確認
rails db:migrate:status

# 必要に応じてマイグレーション実行
rails db:migrate
```

### 5. 環境変数チェック
新しい環境変数を追加した場合：
- `.env.example`の更新
- 必要に応じて開発環境の`.env`ファイル更新

## 提出前チェック
- [ ] Rubocop違反なし
- [ ] Brakeman警告なし  
- [ ] 関連テストが通る
- [ ] 機能が期待通り動作する
- [ ] 環境変数設定が適切

## 注意事項
- OpenAI API Keyが必要な機能をテストする際は適切な設定を確認
- PostgreSQLが起動していることを確認
- CORSの設定がフロントエンドと適合していることを確認