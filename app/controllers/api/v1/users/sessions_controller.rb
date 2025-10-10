class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  # 認証失敗時に、HTMLフォームを呼ぶのではなく、JSONを返すように変更
  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failure" }
  end

  # 認証失敗時のアクション
  def failure
    render json: {
      message: "メールアドレスまたはパスワードが正しくありません"
    }, status: :unauthorized
  end

  # ログイン・ログアウト時のレスポンスを、JSONレスポンス用にオーバーライド
  def respond_with(resource, _opts = {})
    render json: {
      message: "ログインしました",
      user: resource
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: {
      message: "ログアウトしました"
    }, status: :ok
  end
end
