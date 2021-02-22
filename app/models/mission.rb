class Mission < ApplicationRecord
  has_many :today_missions
  has_many :schedules, through: :today_missions
end
