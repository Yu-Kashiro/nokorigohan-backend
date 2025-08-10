require 'rails_helper'

RSpec.describe "Api::V1::UserIngredients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/user_ingredients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/user_ingredients/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/user_ingredients/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/user_ingredients/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
