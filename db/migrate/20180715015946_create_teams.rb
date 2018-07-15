class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :officail_id, null: false
      t.integer :league_id, null: false

      t.timestamps
    end
  end
end
