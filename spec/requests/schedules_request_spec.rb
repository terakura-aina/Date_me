require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  let!(:user) { create(:user) }
  let!(:schedule) { create(:schedule)}

  describe "GET new_schedule_path" do
    it "returns http success" do
      get new_schedule_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post schedules_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/indexlogin"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    xit "returns http success" do
      patch "/schedules/1"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    xit "returns http success" do
      delete "/schedules/1"
      expect(response).to have_http_status(:success)
    end
  end

end
