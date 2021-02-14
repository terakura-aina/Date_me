class Schedule < ApplicationRecord
  require 'date'

  has_one :make_plan, dependent: :destroy
  belongs_to :inviter, class_name: 'User'

  validates :start_planned_day_at, presence: true
  validates :finish_planned_day_at, presence: true
  validates :answer, presence: true

  validate :start_planned_check
  validate :finish_planned_check
  validate :same_day_check

  enum answer: { unanswered: 0, ok: 1, ng: 2 }

  def start_planned_check
    errors.add(:start_planned_day_at, "は現在の日時より遅い時間を選択してください") if self.start_planned_day_at < Time.now
  end

  def finish_planned_check
    errors.add(:finish_planned_day_at, "は開始時刻より遅い時間を選択してください") if self.start_planned_day_at >= self.finish_planned_day_at
  end

  def same_day_check
    errors.add(:finish_planned_day_at, ":start_planned_day_atと同日のみ登録できます") if self.start_planned_day_at.day != self.finish_planned_day_at.day
  end
end
