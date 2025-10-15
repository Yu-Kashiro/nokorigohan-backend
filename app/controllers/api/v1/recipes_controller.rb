class Api::V1::RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:show, :update, :destroy]

  def index
    @recipes = current_user.recipes
    render json: @recipes
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @recipe
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Recipe not found" }, status: :not_found
  end

  def authorize_user!
    unless @recipe.user_id == current_user.id
      render json: { error: "You are not authorized to access this recipe" }, status: :forbidden
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, ingredients: [], instructions: [])
  end
end
