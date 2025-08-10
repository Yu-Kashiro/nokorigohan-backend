require 'rails_helper'

RSpec.describe "Api::V1::UserPreferences", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/user_preferences/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/user_preferences/update"
      expect(response).to have_http_status(:success)
    end
  end

end
