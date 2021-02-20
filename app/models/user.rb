class User < ApplicationRecord
  has_many :asks, class_name: 'MakePlan', foreign_key: 'invited_id', dependent: :destroy
  has_many :answers, class_name: 'MakePlan', foreign_key: 'partner_id', dependent: :destroy
  has_many :partner, through: :asks, source: :partner
  has_many :invites, class_name: 'Schedule', foreign_key: 'invited_id', dependent: :destroy
  has_many :today_missions, dependent: :destroy

  validates :line_user_id, presence: true

end
