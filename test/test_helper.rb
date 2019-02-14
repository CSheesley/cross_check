require "simplecov"
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"
require "pry"
require "csv"

require "./lib/stat_tracker"
require "./lib/game_team"
require "./lib/game"
require "./lib/team"

require "./lib/game_stats"
require "./lib/season_stats"
require "./lib/team_stats"
require "./lib/league_stats"

require "./lib/game_repo"
require "./lib/game_team_repo"
require "./lib/team_repo"
