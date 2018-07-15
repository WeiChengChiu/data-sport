module ScraperHelper

  class MlbGames

    def self.run(first_day = "2018-07-10", last_day = "2018-07-11")
      first_day = first_day.to_datetime
      last_day = last_day.to_datetime
      while first_day <= last_day
        day = first_day.strftime("%Y%m%d")
        league = League.find_by(name: "MLB")
        uri = league.official_site + "scoreboard/?date="  + day
        result = ScraperHelper.get_source_from_uri(uri)
        caught_games = result.css("div div.component.game.margin-24-bottom.mlb.margin-24-bottom.margin-40-top")
        caught_games.each do |caught_game|
          if caught_game["data-gameid"] == nil
            next
          end
          team_info = caught_game.css("div.teams div div.team-name-container")
          start_pitchers_info = caught_game.css("div.right-container div.pitcher-container div.media-body")
          if team_info.css("a")[0] != nil && team_info.css("a")[1] != nil
            away_team_name = team_info.first.css("span.team-name")[0].text
            home_team_name = team_info.last.css("span.team-name")[0].text
            game = Game.find_by(official_id: caught_game["data-gameid"], league_id: league.id)
            if game == nil
              game = Game.new
              game.league_id = League.find_by(name: "MLB").id
              game.official_id = caught_game["data-gameid"]
            end


            status = caught_game.css("div.game-heading div.status-container")[0]
            status_id = nil
            if status != nil
              if status.css("div.status-final")[0] != nil && status.css("div.status-final")[0].text.gsub(/\s+/,"").split("/")[0] == "Final"
                status_id = 2 # closed
                game.away_team_score = caught_game.css("div.teams div div.media-body div.team-score")[0].text.to_f
                game.home_team_score = caught_game.css("div.teams div div.media-body div.team-score")[1].text.to_f
              elsif status.css("strong.status-pregame")[0] != nil
                status_id = 0
                time = "'"
                hour = status.css("strong.status-pregame")[0].text.split(" ")[0].split(":")[0]
                minute = status.css("strong.status-pregame")[0].text.split(" ")[0].split(":")[1]
                if status.css("strong.status-pregame")[0].text.split(" ")[1] == "PM" && hour.to_i != 12
                  hour = (hour.to_i + 12).to_s
                end
                game.game_time = first_day.strftime("%Y-%m-%d") + " " + hour + ":" +minute
              elsif status.css("div.status-final")[0] != nil && status.css("div.status-final")[0].text.gsub(/\s+/,"") == "Postponed"
                status_id = 3 #postpone
              else
                status_id = 1 #start
                game.away_team_score = caught_game.css("div.teams div div.media-body div.team-score")[0].text.to_f
                game.home_team_score = caught_game.css("div.teams div div.media-body div.team-score")[1].text.to_f
              end
            end

            # 過去的比賽不會顯時間
            scheduled = first_day.strftime("%Y-%m-%d")
            game.game_time ||= scheduled

            game.away_team_id = Team.find_by(name: away_team_name).id
            game.home_team_id = Team.find_by(name: home_team_name).id
            game.status = status_id
            game.save
          end
        end

        first_day = first_day + 1.days
      end
    end
  end

end
