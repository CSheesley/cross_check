require "./test/test_helper"

class TeamStatsTest < Minitest::Test

  def test_team_info_with_all_attributes_is_shown
    expected = Hash

    assert_equal expected, team.team_info
  end

  def test_teams_best_season_based_on_win_percentage_can_be_shown
    expected = Integer

    assert_equal expected, team_stats.best_season
  end

  def test_teams_worst_season_based_on_win_percentage_is_shown
    expected = Integer

    assert_equal expected, team_stats.worst_season
  end

  def test_teams_average_win_percentage_of_all_games_is_shown
    expected = Float

    assert_equal expected, team_stats.average_win_percentage
  end

  def test_teams_highest_number_of_goals_in_a_single_game_is_shown
    expected = Integer

    assert_equal expected, team_stats.most_goals_scored
  end

  def test_teams_lowest_number_of_goals_in_a_single_game_is_shown
    expected = Integer

    assert_equal expected, team_stats.fewest_goals_scored
  end

  def test_teams_favorite_opponents_name_is_shown
    expected = String

    assert_equal expected, team_stats.favorite_opponent
  end

  def test_teams_rivals_name_is_shown
    expected = String

    assert_equal expected, team_stats.rival
  end

  def test_teams_biggest_blowout_win_by_goal_differential_is_shown
    expected = Integer

    assert_equal expected, team_stats.biggest_team_blowout
  end

  def test_teams_worst_loss_by_goal_differential_is_shown
    expected = Integer

    assert_equal expected, team_stats.worst_loss
  end

  def test_teams_head_to_head_record_is_shown_versus_a_specific_opponent
    expected = Hash

    assert_equal expected, team_stats.head_to_head(opponent)
    #head_to_head method not shown with an argument
    #but may be a good idea if we specify by opponent
  end

  def test_teams_seasonal_summary_is_shown_for_each_season_it_has_played
    # each season, a hash with two keys (:preseason, :regular_season)
    # each key points to a hash with following keys => :win_percentage,
    #:total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against
    expected = Hash

    assert_equal expected, team_stats.seasonal_summary
  end

end
