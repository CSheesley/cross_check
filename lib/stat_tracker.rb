# require './lib/league_stats'
# require './lib/team_stats'
# require './lib/season_stats'
# require './lib/list_mod'
# require './lib/game_stats'

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
require_relative './game_stats'

require "csv"


class StatTracker
  include TeamStats
  include LeagueStats
  include SeasonStats
  include GameStats
  include List

  attr_accessor :games, :game_teams, :teams

  def self.from_csv(locations)
    st            = StatTracker.new
    st.games      = GameRepo.new(locations[:games])
    st.game_teams = GameTeamRepo.new(locations[:game_teams])
    st.teams      = TeamRepo.new(locations[:teams])
    st
  end
end
