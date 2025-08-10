class Api::V1::ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: [:update]

  def index
    # 現在のユーザーのレシピに関連する買い出しリストを取得
    recipe_ids = current_user.recipes.pluck(:id)
    @shopping_lists = ShoppingList.where(recipe_id: recipe_ids).includes(:recipe)

    # 未購入のもののみフィルタ
    if params[:pending] == 'true'
      @shopping_lists = @shopping_lists.pending
    end

    render json: @shopping_lists.map { |item| shopping_list_json(item) }
  end

  def update
    if @shopping_list.update(shopping_list_params)
      render json: {
        shopping_list: shopping_list_json(@shopping_list),
        message: 'リストを更新しました'
      }
    else
      render json: { errors: @shopping_list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_shopping_list
    recipe_ids = current_user.recipes.pluck(:id)
    @shopping_list = ShoppingList.where(recipe_id: recipe_ids).find(params[:id])
  end

  def shopping_list_params
    params.permit(:purchased)
  end

  def shopping_list_json(shopping_list)
    {
      id: shopping_list.id,
      recipe_id: shopping_list.recipe_id,
      recipe_title: shopping_list.recipe.title,
      ingredient_name: shopping_list.ingredient_name,
      quantity: shopping_list.quantity,
      unit: shopping_list.unit,
      purchased: shopping_list.purchased,
      created_at: shopping_list.created_at,
      updated_at: shopping_list.updated_at
    }
  end
end
