class ApiV1::TeamsController < ApplicationController
  def index
    teams = Team.all
    render :json => teams.to_json
  end
end
