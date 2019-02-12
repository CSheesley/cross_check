
class StatTracker
  attr_accessor :games, :game_teams

  def self.from_csv(locations)
    st = StatTracker.new
    st.games = GameRepo.new(locations[:games],self)
    st.game_teams = GameTeamRepo.new(locations[:game_teams],self)
    st
  end


end
