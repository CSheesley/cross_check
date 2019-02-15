require "./test/test_helper"

class GameStatsTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_can_return_lowest_and_highest_total_scores
    assert_equal 1, @st.lowest_total_score
    assert_equal 10, @st.highest_total_score
  end

  def test_stat_tracker_can_return_away_team_scores
   skip
    expected = []
    
    assert_equal expected, @st.away_team_scores
  end 

  def test_stat_tracker_can_return_home_team_scores
    skip
    expected = 0
    assert_equal expected, @st.home_team_scores
  end 

  def test_stat_tracker_can_return_total_scores
    #helper method, possibly to module 
    expected = [5, 5, 7, 9, 10, 4, 7, 4, 1, 7, 7, 3, 1, 5, 3, 6, 4, 5, 7, 5, 5, 9, 4, 3, 7, 5, 3, 3, 2, 7]
    assert_equal expected, @st.total_scores
  end 

  def test_stat_tracker_can_return_scores_absolute_diff
  end 

  def test_stat_tracker_can_return_biggest_blowout
    skip
    # this one also has mult teams with 5 pt diff, array? 
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_stat_tracker_can_return_home_and_visitor_team_percentage_wins
    skip
    #total_home_wins/total_games = 20/30 = 66.67%
    #total visitor wins/total_games = (30-20)/30 = 33.33%
    #do we add percentage sign?? 

    assert_equal 66.67, @stat_tracker.percentage_home_wins
    assert_equal 33.33, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_return_total_games_played
    skip
    assert_equal 30, @stat_tracker.total_games
  end 

  def test_stat_tracker_can_return_count_of_games_by_season
    skip
    expected = { 20142015 => 6 }
    assert_equal expected, @stat_tracker.count_of_games_by_season(20142015)
  end

  def test_stat_tracker_can_return_average_goals_per_game_all_seasons
    skip
    #total goals = 153/ 30 = 5.10
    assert_equal 5.10, @stat_tracker.average_goals_per_game
  end

  def test_start_tracker_can_return_total_goals_all_seaons
    skip
    assert_equal 153, @stat_tracker.total_goals_all_seasons 
  end 

  def test_stat_tracker_can_return_average_goals_by_season
    skip
    expected = { 20162017 => 5.75 }
    assert_equal expected, @stat_tracker.average_goals_by_season(20162017)
  end
end 

