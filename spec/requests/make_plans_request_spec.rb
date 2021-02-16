require 'rails_helper'

RSpec.describe "MakePlans", type: :request do
  debugger
  let!(:user) { create(:user) }
  let!(:schedule) { create(:schedule)}
  let!(:make_plan) { create(:make_plan) }

  describe "GET /create" do
    xit "returns http success" do
      post make_plans_path
      expect(response).to have_http_status(:success)
    end
  end

end
