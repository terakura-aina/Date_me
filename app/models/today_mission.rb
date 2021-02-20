class TodayMission < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  belongs_to :mission

  enum user_status: { invited: 0, partner: 1 }
  enum mission_status: { until: 0, done: 1 }
end
