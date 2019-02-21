# require './lib/league_stats'
# require './lib/team_stats'
# require './lib/season_stats'
# require './lib/list_mod'
# require './lib/game_stats'
# require './lib/season_most_least'
# require './lib/avg_goals'

require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_repo'
require_relative './team_repo'
require_relative './game_team_repo'
require_relative './league_stats'
require_relative './team_stats'
require_relative './season_stats'
require_relative './list_mod'
require_relative './season_most_least'
require_relative './avg_goals'
require_relative './game_stats'

require "csv"
require "pry"


class StatTracker
  include TeamStats
  include LeagueStats
  include SeasonStats
  include GameStats
  include List
  include SeasonMostLeast
  include AvgGoals

  attr_accessor :games, :game_teams, :teams
  def initialize
    @games = games
    @teams = teams
    @game_teams = game_teams

  end

  def self.from_csv(locations)
    st            = StatTracker.new
    st.games      = GameRepo.new(locations[:games])
    st.game_teams = GameTeamRepo.new(locations[:game_teams])
    st.teams      = TeamRepo.new(locations[:teams])
    st
  end

  def hash_game_teams_by_team
    @game_teams.repo.group_by do |game_team|
      game_team.team_id
    end
  end

  def hash_home_games_by_team
    @games.repo.group_by do |game|
      game.home_team_id
    end
  end

  def hash_away_games_by_team
    @games.repo.group_by do |game|
      game.away_team_id
    end
  end



  def hash_games_by_season
    @games.repo.group_by do |game|
      game.season
    end
  end
end
