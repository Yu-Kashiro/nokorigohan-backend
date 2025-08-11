module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity

    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def record_not_found(e)
    render json: { error: e.message }, status: :not_found
  end

  def unauthorized_request(e)
    render json: { error: e.message }, status: :unauthorized
  end

  def unprocessable_entity(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
