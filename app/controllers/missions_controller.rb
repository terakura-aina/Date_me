class MissionsController < ApplicationController
  def index
    @schedule = Schedule.find_by(token: params[:token])
  end
end
