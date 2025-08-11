Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "shopping_lists/index"
      get "shopping_lists/update"
      get "recipes/index"
      get "recipes/show"
      get "recipes/create"
      get "recipes/destroy"
      get "recipes/generate"
      get "user_ingredients/index"
      get "user_ingredients/create"
      get "user_ingredients/update"
      get "user_ingredients/destroy"
      get "ingredients/index"
      get "ingredients/show"
      get "ingredients/create"
      get "user_preferences/show"
      get "user_preferences/update"
      post "auth/signup", to: "auth#signup"
      post "auth/login", to: "auth#login"

      # ユーザー設定
      resources :user_preferences, only: [ :show, :update ]

      # 食材管理
      resources :ingredients, only: [ :index, :show, :create ]
      resources :user_ingredients, only: [ :index, :create, :update, :destroy ]

      # レシピ関連
      resources :recipes, only: [ :index, :show, :create, :destroy ]
      post "recipes/generate", to: "recipes#generate"

      # 買い出しリスト
      resources :shopping_lists, only: [ :index, :update ]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
