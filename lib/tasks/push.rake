namespace :push do
  desc "push_line"

  task push_mission: :environment do
    schedules = Schedule.where('start_planned_day_at <= ? and finish_planned_day_at > ? and answer = ?', Time.now, Time.now, 1)
    invited_mission = Mission.order("RAND()").first
    partner_mission = Mission.order("RAND()").first
    schedules.each do |schedule|
      message = {
        "type": "template",
        "altText": "ミッションが届いています",
        "template": {
            "thumbnailImageUrl": "https://res.cloudinary.com/dr1peiwz2/image/upload/v1614183954/2021.2.24rose-5_f4u1hp.jpg",
            "type": "buttons",
            "title": "デートを楽しんでいるあなたへ",
            "text": "新しいミッションが届きました！",
            "actions": [
                {
                  "type": "uri",
                  "label": "ミッションを確認する",
                  "uri": "https://liff.line.me/1655665365-robLXJ1P/missions/#{schedule.token}/invited"
                }
            ]
        }
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.invited.line_user_id, message)
      p response

      # partnerにミッションを送る
      message = {
        "type": "template",
        "altText": "ミッションが届いています",
        "template": {
            "thumbnailImageUrl": "https://res.cloudinary.com/dr1peiwz2/image/upload/v1614183954/2021.2.24rose-5_f4u1hp.jpg",
            "type": "buttons",
            "title": "デートを楽しんでいるあなたへ",
            "text": "新しいミッションが届きました！",
            "actions": [
                {
                  "type": "uri",
                  "label": "ミッションを確認する",
                  "uri": "https://liff.line.me/1655665365-robLXJ1P/missions/#{schedule.token}/partner"
                }
            ]
        }
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.partner.line_user_id, message)
      p response

      # TodayMissionテーブルにミッションを保存する
      TodayMission.create(schedule_id: schedule.id, mission_id: invited_mission.id, user_id: schedule.make_plan.invited.id, user_status: 0)
      TodayMission.create(schedule_id: schedule.id, mission_id: partner_mission.id, user_id: schedule.make_plan.partner.id, user_status: 1)
    end
  end

  task push_remind: :environment do
    schedules = Schedule.where('start_planned_day_at = ? and answer = ?', Time.now.since(1440.minutes), 1)
    schedules.each do |schedule|
      message = {
        type: 'text',
        text: '明日はデートの日です！楽しいデートになりますように$',
        "emojis": [
          {
            "index": 25,
            "productId": "5ac1bfd5040ab15980c9b435",
            "emojiId": "009"
          }
        ]
      }
      client = Line::Bot::Client.new{ |config|
	      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
	      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      user_ids = [schedule.make_plan.invited.line_user_id, schedule.make_plan.partner.line_user_id]
      client.multicast(user_ids, message)
    end
  end
end
