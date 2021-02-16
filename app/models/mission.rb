class Mission < ApplicationRecord
  has_many :invites_missions, class_name: 'TodayMission', foreign_key: 'inviter_mission_id', dependent: :destroy
  has_many :partner_missions, class_name: 'TodayMission', foreign_key: 'partner_mission_id', dependent: :destroy
  has_many :schedules, through: :today_missions
end
