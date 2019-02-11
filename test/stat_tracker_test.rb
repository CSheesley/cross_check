require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
  end


  def test_stat_tracker_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end


  def test_stat_tracker_reads_csv
    @st = StatTracker.from_csv(@locations)
    assert_instance_of StatTracker, @st
  end
end
