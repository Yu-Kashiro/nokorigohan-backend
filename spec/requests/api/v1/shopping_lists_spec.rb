require 'rails_helper'

RSpec.describe "Api::V1::ShoppingLists", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/shopping_lists/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/shopping_lists/update"
      expect(response).to have_http_status(:success)
    end
  end

end
