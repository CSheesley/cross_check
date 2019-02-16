require "./lib/league_stats"
require './lib/team_stats'
require './lib/season_stats'
require './lib/game_stats'
require "./lib/list_mod"
​
class StatTracker
  include TeamStats
  include LeagueStats
  include SeasonStats
  include GameStats
  include List
​
  attr_accessor :games, :game_teams, :teams
​
  def self.from_csv(locations)
    st      = StatTracker.new
    st.games   = GameRepo.new(locations[:games], self)
    st.game_teams = GameTeamRepo.new(locations[:game_teams], self)
    st.teams   = TeamRepo.new(locations[:teams], self)
    st
  end
end