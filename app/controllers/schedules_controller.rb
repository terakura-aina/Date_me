class SchedulesController < ApplicationController
  require 'net/http'
  require 'uri'

  def show
    render layout: 'top'
  end

  def index
    # 終了予定時間が今よりあと&answerカラムがOKのものを@schedulesに代入
    @schedules = Schedule.where('finish_planned_day_at > ? and answer = ?', Time.now, 1).order(start_planned_day_at: :asc)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    user = User.find(session[:user_id])
    @schedule = Schedule.new(schedule_params)
    if @schedule.update(token: SecureRandom.hex(32),invited_id: user.id)
      @schedule.update(token: SecureRandom.hex(32),invited_id: user.id)
      render json: @schedule
      message = {
        "type": "text",
        "text": "デートのお誘いをしています！\nお返事があるまでお待ちください$",
        "emojis": [
          {
            "index": 30,
            "productId": "5ac1bfd5040ab15980c9b435",
            "emojiId": "009"
          }
        ]
      }
      client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(@schedule.invited.line_user_id, message)
      p response
    else
      respond_to do |format|
        format.js { render 'create', status: 400 }
        format.js { render 'create' }
      end
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @schedule = Schedule.find_by(token: params[:token])
    if @schedule == nil
      render file: 'public/cancel.html', status: 200, layout: false
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.assign_attributes(answer: 1)
    # 開始時刻より後でもOKできるように、バリデーションスキップ
    @schedule.save!(validate: false)
    render json: @schedule
    message = {
      "type": "text",
      "text": "デートがOKされました！",
    }
    client = Line::Bot::Client.new { |config|
    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(@schedule.invited.line_user_id, message)
    p response
    message = {
      "type": "text",
      "text": "デートをOKしました！",
    }
    client = Line::Bot::Client.new { |config|
    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(User.find(session[:user_id]).line_user_id, message)
    p response
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy!
    message = {
      "type": "text",
      "text": "デートがキャンセルされました$",
      "emojis": [
          {
            "index": 14,
            "productId": "5ac1bfd5040ab15980c9b435",
            "emojiId": "046"
          }
        ]
    }
    client = Line::Bot::Client.new { |config|
    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }

    response = client.push_message(@schedule.invited.line_user_id, message)
    p response

    message = {
      "type": "text",
      "text": "デートがキャンセルされました$",
      "emojis": [
          {
            "index": 14,
            "productId": "5ac1bfd5040ab15980c9b435",
            "emojiId": "046"
          }
        ]
    }
    client = Line::Bot::Client.new { |config|
    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(cancel_user, message)
    p response
  end

  def login; end

  def indexlogin; end

  private

  def schedule_params
    params.require(:schedule).permit(:start_planned_day_at, :finish_planned_day_at, :other, :invited_id)
  end

  def cancel_user
      if @schedule.answer == 'ok'
        @schedule.make_plan.partner.line_user_id
      else
        User.find(session[:user_id]).line_user_id
      end
  end
end
