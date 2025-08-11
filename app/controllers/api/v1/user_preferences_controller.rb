class Api::V1::UserPreferencesController < ApplicationController
  before_action :set_user_preference

  def show
    render json: @user_preference
  end

  def update
    if @user_preference.update(user_preference_params)
      render json: {
        user_preference: @user_preference,
        message: "設定を更新しました"
      }
    else
      render json: { errors: @user_preference.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user_preference
    @user_preference = current_user.user_preference || current_user.create_user_preference!
  end

  def user_preference_params
    params.permit(
      :default_serving_size,
      nutritional_goals: [ :daily_calories, :protein_ratio, :carb_ratio, :fat_ratio ],
      allergies: [],
      cooking_tools: [],
      seasonings: []
    )
  end
end
