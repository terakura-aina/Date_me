require 'rails_helper'

RSpec.describe "MakePlans", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/make_plans/create"
      expect(response).to have_http_status(:success)
    end
  end

end
