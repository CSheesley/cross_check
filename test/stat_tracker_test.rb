require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end


  def test_stat_tracker_reads_csv
    @st = StatTracker.from_csv(@locations)
    assert_instance_of StatTracker, @st
  end

  def test_stat_tracker_makes_game_repo_when_initialized
    @st = StatTracker.from_csv(@locations)
    assert_instance_of GameRepo, @st.games
    assert_equal 30, @st.games.repo.count
    assert_equal 3, @st.games.repo.first.away_goals
  end

end
