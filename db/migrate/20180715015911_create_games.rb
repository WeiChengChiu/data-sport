class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :official_id, null: false
      t.integer :league_id, null: false
      t.datetime :game_time, null: false
      t.integer :home_team_id, null: false
      t.integer :awat_team_id, null: false
      t.float :home_team_score, default: 0.0
      t.float :away_team_score, default: 0.0
      t.integer :status, null: false

      t.timestamps
    end
  end
end
