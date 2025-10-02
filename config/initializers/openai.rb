# frozen_string_literal: true

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
  config.log_errors = Rails.env.development? || Rails.env.test?
end
