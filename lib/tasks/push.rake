namespace :push do
  desc "push_line"

  task push_mission: :environment do
    schedules = Schedule.where('start_planned_day_at <= ? and finish_planned_day_at > ? and answer = ?', Time.now, Time.now, 1)
    inviter_mission = Mission.order("RAND()").first
    partner_mission = Mission.order("RAND()").first
    schedules.each do |schedule|
      message = {
        type: 'text',
        text: inviter_mission.body
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.inviter.line_user_id, message)
      p response

      # partnerにミッションを送る
      message = {
        type: 'text',
        text: partner_mission.body
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.partner.line_user_id, message)
      p response

      # TodayMissionテーブルにミッションを保存する
      TodayMission.create(schedule_id: schedule.id, inviter_mission_id: inviter_mission.id, partner_mission_id: partner_mission.id)
    end
  end

  task push_remind: :environment do
    schedules = Schedule.where('start_planned_day_at <= ? and start_planned_day_at >= ? and answer = ?', Time.now.since(1.hours), Time.now.since(1.hours).since(1.minutes), 1)
    schedules.each do |schedule|
      message = {
        type: 'text',
        text: 'デート1時間前です！'
      }
      client = Line::Bot::Client.new{ |config|
	      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
	      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      user_ids = [schedule.make_plan.inviter.line_user_id, schedule.make_plan.partner.line_user_id]
      client.multicast(user_ids, message)
    end
  end
end
