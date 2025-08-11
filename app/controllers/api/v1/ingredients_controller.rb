class Api::V1::IngredientsController < ApplicationController
  skip_before_action :authorize_request, only: [ :index, :show ]
  before_action :set_ingredient, only: [ :show ]

  def index
    @ingredients = Ingredient.all
    if params[:category].present?
      @ingredients = @ingredients.by_category(params[:category])
    end
    render json: @ingredients.order(:category, :name)
  end

  def show
    render json: @ingredient
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      render json: {
        ingredient: @ingredient,
        message: "食材を追加しました"
      }, status: :created
    else
      render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.permit(:name, :category, :unit)
  end
end
