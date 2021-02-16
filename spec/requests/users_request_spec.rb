require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /create" do
    let!(:user) { create(:user) }

    it "returns http success" do
      post users_path
      expect(response).to have_http_status(:success)
    end
  end

end
