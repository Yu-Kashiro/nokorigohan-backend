class Api::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :destroy ]

  def index
    @recipes = current_user.recipes.recent
    render json: @recipes
  end

  def show
    render json: recipe_json(@recipe)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      render json: {
        recipe: recipe_json(@recipe),
        message: "レシピを保存しました"
      }, status: :created
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    render json: { message: "レシピを削除しました" }
  end

  def generate
    serving_size = params[:serving_size]&.to_i || current_user.user_preference&.default_serving_size || 2

    # ユーザーの利用可能な食材を取得
    user_ingredients = current_user.user_ingredients.available.includes(:ingredient)

    if user_ingredients.empty?
      return render json: { error: "食材が登録されていません" }, status: :unprocessable_entity
    end

    # ユーザー設定を取得
    user_preferences = current_user.user_preference
    unless user_preferences
      return render json: { error: "ユーザー設定が見つかりません" }, status: :unprocessable_entity
    end

    begin
      openai_service = OpenaiService.new
      recipes_data = openai_service.generate_recipes(user_ingredients, user_preferences, serving_size)

      # レシピをデータベースに保存（一時的）
      leftover_recipe = save_generated_recipe(recipes_data["leftover_only"], "leftover_only", serving_size)
      balanced_recipe = save_generated_recipe(recipes_data["balanced"], "balanced", serving_size)

      # 買い出しリストを作成（バランスレシピ用）
      shopping_list = create_shopping_list(balanced_recipe, recipes_data["balanced"]["additional_ingredients"]) if recipes_data["balanced"]["additional_ingredients"]

      render json: {
        recipes: {
          leftover_only: recipe_json(leftover_recipe),
          balanced: recipe_json(balanced_recipe, shopping_list)
        },
        message: "レシピを生成しました"
      }
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.permit(:title, :instructions, :cooking_time, :serving_size, :recipe_type, nutritional_info: {})
  end

  def recipe_json(recipe, shopping_list = nil)
    result = {
      id: recipe.id,
      title: recipe.title,
      instructions: recipe.instructions,
      cooking_time: recipe.cooking_time,
      serving_size: recipe.serving_size,
      recipe_type: recipe.recipe_type,
      nutritional_info: recipe.nutritional_info,
      created_at: recipe.created_at,
      updated_at: recipe.updated_at
    }

    if shopping_list
      result[:shopping_list] = shopping_list.map do |item|
        {
          id: item.id,
          ingredient_name: item.ingredient_name,
          quantity: item.quantity,
          unit: item.unit,
          purchased: item.purchased
        }
      end
    end

    result
  end

  def save_generated_recipe(recipe_data, recipe_type, serving_size)
    current_user.recipes.create!(
      title: recipe_data["title"],
      instructions: recipe_data["instructions"],
      cooking_time: recipe_data["cooking_time"],
      serving_size: serving_size,
      recipe_type: recipe_type,
      nutritional_info: recipe_data["nutritional_info"]
    )
  end

  def create_shopping_list(recipe, additional_ingredients)
    return [] unless additional_ingredients

    additional_ingredients.map do |ingredient_data|
      recipe.shopping_lists.create!(
        ingredient_name: ingredient_data["name"],
        quantity: ingredient_data["quantity"],
        unit: ingredient_data["unit"]
      )
    end
  end
end
