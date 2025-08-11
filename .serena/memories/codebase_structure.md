# コードベース構造

## ディレクトリ構造

### バックエンド (nokorigohan-backend/)
```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── api/v1/                    # API v1エンドポイント
│   │   ├── auth_controller.rb     # 認証API
│   │   ├── recipes_controller.rb  # レシピ生成API
│   │   ├── user_preferences_controller.rb
│   │   ├── ingredients_controller.rb
│   │   ├── user_ingredients_controller.rb
│   │   └── shopping_lists_controller.rb
│   └── concerns/
│       ├── exception_handler.rb   # エラー処理
│       └── json_web_token.rb      # JWT認証
├── models/                        # ActiveRecordモデル
│   ├── user.rb
│   ├── user_preference.rb
│   ├── ingredient.rb
│   ├── user_ingredient.rb
│   ├── recipe.rb
│   └── shopping_list.rb
└── services/                      # ビジネスロジック
    ├── openai_service.rb          # GPT-5 mini連携
    └── jwt_service.rb             # JWT管理

spec/                              # テストファイル
├── models/                        # モデルテスト
├── requests/api/v1/              # APIテスト
└── factories/                     # Factory Bot設定
```

### フロントエンド (nokorigohan-frontend/)
- Next.js 15 App Router構成
- TypeScript使用

## 重要なファイル
- `app/services/openai_service.rb` - GPT-5 mini連携
- `app/controllers/api/v1/recipes_controller.rb` - レシピ生成API
- `config/routes.rb` - APIルーティング設定
- `db/migrate/` - データベースマイグレーション
- `.env.example` - 環境変数設定例