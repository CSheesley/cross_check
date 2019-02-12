require './lib/stat_tracker'
require "./lib/game"
require "./lib/game_repo"
require "./lib/team"
# require "./lib/team_repo"
require "./lib/game_team"
# require "./lib/game_team_repo"
require "csv"
require "pry"

game_path = './data/game_fixture.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats_fixture.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
#this stat tracker is the instance of StatTracker that is instantiated by running the ::from_csv method

binding.pry
