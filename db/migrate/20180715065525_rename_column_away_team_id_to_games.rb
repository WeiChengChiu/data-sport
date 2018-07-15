class RenameColumnAwayTeamIdToGames < ActiveRecord::Migration[5.2]
  def change
    rename_column :games, :awat_team_id, :away_team_id
  end
end
