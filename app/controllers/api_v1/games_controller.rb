class ApiV1::GamesController < ApplicationController
  def index
    games = Game.all
    render :json => games.to_json
  end
end
