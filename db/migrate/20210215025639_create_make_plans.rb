class CreateMakePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :make_plans do |t|
      t.references :invited, null: false, foreign_key: { to_table: :users }, index: true
      t.references :partner, null: false, foreign_key: { to_table: :users }, index: true
      t.references :schedule, null: false, foreign_key: true, index: {unique: true}

      t.timestamps
    end
  end
end
