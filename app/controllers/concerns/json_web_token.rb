module JsonWebToken
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  def authorize_request
    @current_user = user_from_token(decoded_auth_token[:user_id])
  end

  private

  def decoded_auth_token
    @decoded_auth_token ||= JwtService.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers["Authorization"].present?
      return request.headers["Authorization"].split(" ").last
    end
    raise ExceptionHandler::MissingToken, "トークンがありません"
  end

  def user_from_token(user_id)
    User.find(user_id) || raise(ExceptionHandler::InvalidToken, "無効なトークンです")
  rescue ActiveRecord::RecordNotFound => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
