class TodayMission < ApplicationRecord
  belongs_to :schedule
  belongs_to :inviter_mission, class_name: 'Mission'
  belongs_to :partner_mission, class_name: 'Mission'
end
