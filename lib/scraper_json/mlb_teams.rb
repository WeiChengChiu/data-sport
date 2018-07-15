module ScraperJsonHelper
  class MlbTeams
    def self.run()

        url = 'https://stats.api.si.com/v1/mlb/teams'
        result = ScraperJsonHelper.get_source_from_uri(url)
        league_mlb = League.find_by(name: "MLB")

        teams = result["data"]
        teams.each do |team|
          next if Team.find_by(officail_id: team["id"]) != nil

          t = Team.new
          t.name = team["name"]
          t.officail_id = team["id"]
          t.league_id = league_mlb.id
          t.save
          puts t
        end
    end
  end
end


