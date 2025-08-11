# 推奨コマンド

## 開発環境起動
```bash
# 開発サーバー起動（フロント・バック両方）
./dev-start.sh

# または個別起動
cd nokorigohan-backend && rails server -p 3001  # バックエンド
cd nokorigohan-frontend && npm run dev          # フロントエンド

# バックエンドのみ（dev scriptsを使用）
./bin/dev
```

## テスト実行
```bash
# RSpecテスト実行
bundle exec rspec

# 特定のテストファイル実行
bundle exec rspec spec/models/user_spec.rb

# 特定のテスト実行
bundle exec rspec spec/models/user_spec.rb:10
```

## コード品質チェック
```bash
# Rubocop（スタイルチェック・修正）
bundle exec rubocop
bundle exec rubocop -a  # 自動修正

# Brakeman（セキュリティチェック）
bundle exec brakeman
```

## データベース操作
```bash
# マイグレーション実行
rails db:migrate

# データベース作成・初期化
rails db:setup

# シードデータ投入
rails db:seed

# データベースリセット
rails db:reset
```

## システム関連（macOS）
```bash
# ファイル検索
find . -name "*.rb" -type f

# パターン検索
grep -r "pattern" app/

# ディレクトリ一覧
ls -la

# Git操作
git status
git add .
git commit -m "message"
```