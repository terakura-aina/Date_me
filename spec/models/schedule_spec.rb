require 'rails_helper'

RSpec.describe Schedule, type: :model do
  #let! => 各ブロックを実行する前にセットされる(!がないと呼び出されてからcreateされる)
  let!(:user) { create(:user) }

  it '開始時間、終了時間がある場合、有効である' do
    schedule = build(:schedule)
    expect(schedule).to be_valid
  end

  it '開始時間が空欄の場合、無効である' do
    schedule = build(:schedule, start_planned_day_at: nil)
    expect(schedule).to be_invalid
    expect(schedule.errors[:start_planned_day_at]).to include("は入力必須です")
  end

  it '終了時間が空欄の場合、無効である' do
    schedule = build(:schedule, finish_planned_day_at: nil)
    expect(schedule).to be_invalid
    expect(schedule.errors[:finish_planned_day_at]).to include("は入力必須です")
  end

  it '開始時間が現在時刻より早い場合、無効である' do
    schedule = build(:schedule, start_planned_day_at: Time.now.ago(1.minutes))
    expect(schedule).to be_invalid
    expect(schedule.errors[:start_planned_day_at]).to include("は現在の日時より遅い時間を選択してください")
  end

  it '終了時間が開始時間と同じ場合、無効である' do
    schedule = build(:schedule, finish_planned_day_at: "2025-02-12 18:00")
    expect(schedule).to be_invalid
    expect(schedule.errors[:finish_planned_day_at]).to include("は開始時間より遅い時間を選択してください")
  end

  it '終了時間が開始時間より早い場合、無効である' do
    schedule = build(:schedule, finish_planned_day_at: "2025-02-12 17:00")
    expect(schedule).to be_invalid
    expect(schedule.errors[:finish_planned_day_at]).to include("は開始時間より遅い時間を選択してください")
  end

  it '開始時間と終了時間が別日の場合、無効である' do
    schedule = build(:schedule, finish_planned_day_at: "2025-02-13 18:00")
    expect(schedule).to be_invalid
    expect(schedule.errors[:finish_planned_day_at]).to include("と同日のみ登録できます")
  end
end
