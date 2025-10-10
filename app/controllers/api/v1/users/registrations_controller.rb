class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # Strong Parametersを上書き（なぜデフォルトの標準パラメータが使用できない？）
  def sign_up_params
    params.expect(user: [ :email, :password, :password_confirmation ])
  end

  # セッションを作成しないようにオーバーライド
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource, store: false)
  end

  # JSONレスポンスを返すようにオーバーライド
  def respond_with(resource, _opts = {})
    if resource.persisted?
      successful_registration(resource)
    else
      failed_registration
    end
  end

  # 成功時のレスポンス内容
  def successful_registration(resource)
    render json: {
      message: "新規登録が完了しました",
      user: resource
    }, status: :ok
  end

  # 失敗時のレスポンス内容
  def failed_registration
    render json: {
      message: "新規登録に失敗しました。もう一度お試しください。"
    }, status: :unprocessable_entity
  end
end
