require 'rails_helper'

RSpec.describe "Missions", type: :request do

  describe "GET /missions/:token/:user" do
    it "returns http success" do
      get "/missions/MyText/inviter"
      expect(response).to have_http_status(:success)
    end
  end

end
