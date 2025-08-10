class ApplicationController < ActionController::API
  include ExceptionHandler
  include JsonWebToken

  before_action :authorize_request
end
