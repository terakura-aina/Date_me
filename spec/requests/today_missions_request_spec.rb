require 'rails_helper'

RSpec.describe "TodayMissions", type: :request do

  describe "GET /update" do
    it "returns http success" do
      get "/today_missions/update"
      expect(response).to have_http_status(:success)
    end
  end

end
