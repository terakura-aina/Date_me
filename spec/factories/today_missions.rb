FactoryBot.define do
  factory :today_mission do
    schedule { 1 }
    invited_mission { 1 }
    partner_mission { 1 }
  end
end
