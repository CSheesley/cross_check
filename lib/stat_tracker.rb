
class StatTracker
  attr_accessor :games

  def self.from_csv(locations)
    st = StatTracker.new
    st.games = GameRepo.new(locations[:games],self)
    st
  end


end
