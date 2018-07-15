class TeamsController < ApplicationController
  require "scraper_json_helper.rb"
  require "scraper_json/mlb_teams.rb"

  def index
    @teams = Team.all
  end

  def destroy_all
    Team.destroy_all
    redirect_to teams_path
  end

  def update_all
    ScraperJsonHelper::MlbTeams.run
    redirect_to teams_path
  end
end
