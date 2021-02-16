require 'rails_helper'

RSpec.describe "Missions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/missions/index"
      expect(response).to have_http_status(:success)
    end
  end

end
