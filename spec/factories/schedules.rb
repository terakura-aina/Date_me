FactoryBot.define do
  factory :schedule do
    start_planned_day_at { "2021-02-12 21:51:23" }
    finish_planned_day_at { "2021-02-12 21:51:23" }
    place { "MyText" }
    other { "MyText" }
    answer { 1 }
    token { "MyText" }
  end
end
