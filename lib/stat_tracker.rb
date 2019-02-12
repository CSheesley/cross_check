
class StatTracker
  attr_accessor :games

  def self.from_csv(locations)
    st = StatTracker.new
    st.games = GameRepo.new(locations[:games],self)
    st
  end


end


# def test_stat_tracker_makes_game_repo_when_initialized
#   assert_instance_of GameRepo, @stat_tracker.games
#   assert_equal 30, @stat_tracker.games.repo.count
#   assert_equal 3, @stat_tracker.games.repo.first.away_goals
# end
