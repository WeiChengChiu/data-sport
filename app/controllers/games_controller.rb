class GamesController < ApplicationController
  require "scraper_helper.rb"
  require "scraper/mlb_games.rb"

  def index
    @games = Game.includes(:home_team, :away_team)
  end

  def destroy_all
    Game.destroy_all

    redirect_to games_path
  end

  def update_all
    ScraperHelper::MlbGames.run
    redirect_to games_path
  end
end
