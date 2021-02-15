class MakePlan < ApplicationRecord
  # invitedモデルを探しにいってしまうので、class_nameを指定してあげる
  belongs_to :inviter, class_name: 'User'
  belongs_to :partner, class_name: 'User'
  belongs_to :schedule

  validates :schedule_id, uniqueness: true
end
