class CreateTodayMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :today_missions do |t|
      t.references :schedule, null: false, foreign_key: true, index: true
      t.references :inviter_mission, null: false, foreign_key: { to_table: :missions }, index: true
      t.references :partner_mission, null: false, foreign_key: { to_table: :missions }, index: true

      t.timestamps
    end
  end
end
