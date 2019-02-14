require "./lib/league_stats"
require './lib/team_stats'

class StatTracker
  include TeamStats
  include LeagueStats

  attr_accessor :games, :game_teams, :teams

  def self.from_csv(locations)
    st            = StatTracker.new
    st.games      = GameRepo.new(locations[:games], self)
    st.game_teams = GameTeamRepo.new(locations[:game_teams], self)
    st.teams      = TeamRepo.new(locations[:teams], self)
    st
  end
end
