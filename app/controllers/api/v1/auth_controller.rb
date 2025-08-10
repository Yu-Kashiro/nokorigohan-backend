class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: [:signup, :login]

  def signup
    user = User.new(user_params)
    
    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: {
        user: user_response(user),
        token: token,
        message: 'ユーザー登録が完了しました'
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: {
        user: user_response(user),
        token: token,
        message: 'ログインしました'
      }
    else
      render json: { error: 'メールアドレスまたはパスワードが正しくありません' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def user_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      created_at: user.created_at
    }
  end
end
