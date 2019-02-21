require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_repo'
require './lib/team_repo'
require './lib/game_team_repo'
require './lib/league_stats'
require './lib/team_stats'
require './lib/season_stats'
require './lib/list_mod'
require './lib/season_most_least'
require './lib/avg_goals'
require './lib/game_stats'
require './lib/hash_module'
require './lib/summary_module'
require './lib/season_module'
require './lib/stat_tracker'

require "csv"
require "pry"

game_path = './data/game_fixture.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_team_stats_fixture.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
binding.pry
