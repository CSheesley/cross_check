require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
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

  def test_stat_tracker_makes_game_repo_when_initialized
    @st = StatTracker.from_csv(@locations)
    assert_instance_of GameRepo, @st.games
    assert_equal 30, @st.games.repo.count
    assert_equal 3, @st.games.repo.first.away_goals
  end

  # def test_stat_tracker_can_return_lowest_and_highest_total_scores
  #   skip
  #   Expected = integer
  #   assert_equal Expected, @stat_tracker.lowest_total_score
  #   assert_equal Expected, @stat_tracker.highest_total_score
  # end

  # def test_stat_tracker_can_return_biggest_blowout
  #   skip
  #   Expected = integer
  #   assert_equal Expected, @stat_tracker.biggest_blowout
  # end

  # def test_stat_tracker_can_return_home_and_visitor_team_percentage_wins
  #   skip
  #   Expected = float, round(2) # to the nearest one hundredth
  #   assert_equal Expected, @stat_tracker.percentage_home_wins
  #   assert_equal Expected, @stat_tracker.percentage_visitor_wins
  # end

  # def test_stat_tracker_can_return_count_of_games_by_season
  #   skip
  #   Expected = hash
  #   assert_equal Expected, @stat_tracker.count_of_games_by_season
  # end

  # def test_stat_tracker_can_return_average_goals_per_game
  #   skip
  #   Expected = Float, round(2)
  #   assert_equal Expected, @stat_tracker.average_goals_per_game
  # end

  # def test_stat_tracker_can_return_average_goals_by_season
  #   skip
  #   Expected = hash
  #   assert_equal Expected, @stat_tracker.average_goals_by_season
  # end
end
