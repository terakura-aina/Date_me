class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.datetime :start_planned_day_at, null: false
      t.datetime :finish_planned_day_at, null: false
      t.text :place
      t.text :other
      t.integer :answer, null: false, default: 0
      t.text :token, null: false
      t.references :inviter, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end