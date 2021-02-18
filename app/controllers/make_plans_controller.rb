class MakePlansController < ApplicationController
  require 'net/http'
  require 'uri'

  def create
    idToken = params[:idToken]
    channelId = '1655665365'
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                          {'id_token'=>idToken, 'client_id'=>channelId})
    render :json => res.body
    partner_id = params[:dataId]
    schedule = Schedule.find_by(token: params[:scheduleToken])
    invited_id = schedule.invited_id
    plan = MakePlan.new(invited_id: invited_id, partner_id: partner_id,schedule_id: schedule.id)
    # 誤って二重に登録するのを防止
    plan.save! if MakePlan.find_by(schedule_id: schedule.id) == nil
  end
end
