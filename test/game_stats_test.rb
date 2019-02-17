require "./test/test_helper"
require 'pry'

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

  def test_stat_tracker_can_return_total_scores
    #helper method, possibly to module 
    expected = [5, 5, 7, 9, 10, 4, 7, 4, 1, 7, 7, 3, 1, 5, 3, 6, 4, 5, 7, 5, 5, 9, 4, 3, 7, 5, 3, 3, 2, 7]

    assert_equal expected, @st.total_scores
  end 

  def test_stat_tracker_can_return_biggest_blowout
    assert_equal 5, @st.biggest_blowout
  end

  def test_stat_tracker_can_return_teams_score_difference_for_each_game 
    #helper method for biggest_blowout 
    expected = [1, -5, 1, 1, -2, -4, 1, -2, -1, -1, -1, -1, -1, 5, -1, -2, -2, 1, -1, -1, -1, 1, 2, 1, -1, 1, -1, 1, -2, -3]
   
    assert_equal expected, @st.teams_score_difference 
  end 

  def test_stat_tracker_can_return_home_and_visitor_team_percentage_wins
    assert_equal 0.63, @st.percentage_home_wins
    assert_equal 0.37, @st.percentage_visitor_wins
  end

  def test_it_can_return_total_games_played
    assert_equal 30, @st.total_games
  end 

  def test_it_can_return_total_visitor_wins
    assert_equal 11, @st.total_visitor_wins
  end

  def test_stat_tracker_can_return_count_of_games_by_season
    expected = { 20142015 => 6 }
    assert_equal expected, @st.count_of_games_by_season(20142015)
  end

  def test_stat_tracker_can_return_average_goals_per_game_all_seasons
    assert_equal 5.10, @st.average_goals_per_game
  end

  def test_start_tracker_can_return_total_goals_all_seaons
    assert_equal 153, @st.total_goals_all_seasons 
  end 

  def test_stat_tracker_can_return_average_goals_by_season
    skip
    expected = { 20162017 => 5.75 }
    assert_equal expected, @st.average_goals_by_season(20162017)
  end

  def test_stat_tracker_can_return_total_goals_by_season
    assert_equal 23, @st.total_goals_by_season(20162017)
  end 

  def test_stat_tracker_can_return_games_by_season 
    assert_equal 4, @st.games_by_season(20162017)
  end 
end 