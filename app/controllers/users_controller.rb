class UsersController < ApplicationController
  def create
    idToken = params[:idToken]
    channelId = ENV['CHANNEL_ID']
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                          {'id_token'=>idToken, 'client_id'=>channelId})
    line_user_id = JSON.parse(res.body)["sub"]
    user = User.find_by(line_user_id: line_user_id)
    if user.nil?
      user = User.create(line_user_id: line_user_id)
      session[:user_id] = user.id
      render :json => user
    elsif user
      session[:user_id] = user.id
      render :json => user
    end
  end
end
