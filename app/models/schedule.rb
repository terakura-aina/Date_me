class Schedule < ApplicationRecord
  require 'date'

  has_one :make_plan, dependent: :destroy
  belongs_to :inviter, class_name: 'User'
  has_many :today_missions, dependent: :destroy
  has_many :invited_missions, through: :today_missions, source: :inviter_mission
  has_many :partner_missions, through: :today_missions, source: :partner_mission

  validates :answer, presence: true

  validate :start_planned_check
  validate :finish_planned_check
  validate :same_day_check

  enum answer: { unanswered: 0, ok: 1, ng: 2 }

  def start_planned_check
    if start_planned_day_at.blank?
      errors.add(:start_planned_day_at, "は入力必須です")
    elsif self.start_planned_day_at == nil
      errors.add(:finish_planned_day_at, "は入力必須です")
    elsif self.start_planned_day_at < Time.now
      errors.add(:start_planned_day_at, "は現在の日時より遅い時間を選択してください")
    end
  end

  def finish_planned_check
    if finish_planned_day_at.blank?
      errors.add(:finish_planned_day_at, "は入力必須です")
    elsif self.start_planned_day_at == nil
      errors.add(:start_planned_day_at, "は入力必須です")
    elsif self.start_planned_day_at >= self.finish_planned_day_at
      errors.add(:finish_planned_day_at, "は開始時間より遅い時間を選択してください")
    end
  end

  def same_day_check
    if start_planned_day_at.blank?
      errors.add(:finish_planned_day_at, "は入力必須です")
    elsif finish_planned_day_at.blank?
      errors.add(:finish_planned_day_at, "は入力必須です")
    elsif self.start_planned_day_at.day != self.finish_planned_day_at.day
      errors.add(:finish_planned_day_at, "と同日のみ登録できます")
    end
  end
end
