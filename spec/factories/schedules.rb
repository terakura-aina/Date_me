FactoryBot.define do
  factory :schedule do
    start_planned_day_at { "2025-02-12 18:00" }
    finish_planned_day_at { "2025-02-12 22:00" }
    place { "MyText" }
    other { "MyText" }
    answer { 0 }
    token { "MyText" }
    invited_id { 1 }
  end
end
