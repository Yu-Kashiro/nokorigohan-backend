class Api::V1::UserIngredientsController < ApplicationController
  before_action :set_user_ingredient, only: [:show, :update, :destroy]

  def index
    @user_ingredients = current_user.user_ingredients.includes(:ingredient)
    
    # 利用可能な食材のみフィルタ
    if params[:available] == 'true'
      @user_ingredients = @user_ingredients.available
    end
    
    # 期限切れ近い食材のみフィルタ
    if params[:expiring_soon] == 'true'
      @user_ingredients = @user_ingredients.expiring_soon
    end

    render json: @user_ingredients.map { |ui| user_ingredient_json(ui) }
  end

  def create
    @user_ingredient = current_user.user_ingredients.build(user_ingredient_params)
    
    if @user_ingredient.save
      render json: {
        user_ingredient: user_ingredient_json(@user_ingredient),
        message: '食材を追加しました'
      }, status: :created
    else
      render json: { errors: @user_ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user_ingredient.update(user_ingredient_params)
      render json: {
        user_ingredient: user_ingredient_json(@user_ingredient),
        message: '食材を更新しました'
      }
    else
      render json: { errors: @user_ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_ingredient.destroy
    render json: { message: '食材を削除しました' }
  end

  private

  def set_user_ingredient
    @user_ingredient = current_user.user_ingredients.find(params[:id])
  end

  def user_ingredient_params
    params.permit(:ingredient_id, :quantity, :expiration_date)
  end

  def user_ingredient_json(user_ingredient)
    {
      id: user_ingredient.id,
      ingredient: {
        id: user_ingredient.ingredient.id,
        name: user_ingredient.ingredient.name,
        category: user_ingredient.ingredient.category,
        unit: user_ingredient.ingredient.unit
      },
      quantity: user_ingredient.quantity,
      expiration_date: user_ingredient.expiration_date,
      created_at: user_ingredient.created_at,
      updated_at: user_ingredient.updated_at
    }
  end
end
