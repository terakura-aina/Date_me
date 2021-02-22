class CreateTodayMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :today_missions do |t|
      t.references :schedule, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :mission, null: false, foreign_key: true, index: true
      t.integer :user_status, null: false
      t.integer :mission_status, null: false, default: 0

      t.timestamps
    end
  end
end
