require "./test/test_helper"

class TeamStatsTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  # not working as expected...
  # def test_team_info_with_all_attributes_is_shown
  #   #expected = Hash
  #   assert_instance_of Hash, @stat_tracker.team_info(17)
  # end

  # def test_all_games_played_can_be_gathered #helper
  #   #6 is the correct count of game_team objects in the array
  #   #wasnt sure how to fill an array with these objects for testing
  #   assert_equal 6, @stat_tracker.all_games_played(17).count
  # end

  def test_all_seasons_played_by_a_team_can_be_added_to_a_list

    assert_equal [2011, 2012], @stat_tracker.seasons(17)
  end

  # def test_teams_best_and_worst_season_based_on_win_percentage_can_be_shown
  #   #expected = Integer
  #   assert_equal 2011, @stat_tracker.best_season(17) #50%
  #   assert_equal 2012, @stat_tracker.worst_season(17) #33%
  # end

  # def test_teams_average_win_percentage_of_all_games_is_shown
  #   # expected = Float
  #   assert_equal 50.0, @stat_tracker.average_win_percentage(17)
  # end
  #
  # def test_teams_highest_and_lowest_number_of_goals_in_a_single_game_is_shown
  #   # expected = Integer
  #   assert_equal 4, @stat_tracker.most_goals_scored(17)
  #   assert_equal 1, @stat_tracker.fewest_goals_scored(17)
  # end
  #
  # def test_teams_favorite_opponents_name_is_shown
  #   expected = String
  #   assert_equal "Blackhawks", @stat_tracker.favorite_opponent(17)
  # end
  #
  # def test_teams_rivals_name_is_shown
  #   expected = String
  #   assert_equal "Blackhawks", @stat_tracker.rival(17)
  # end
  #
  # def test_teams_biggest_blowout_win__and_worst_loss_by_goal_differential_is_shown
  #   expected = Integer
  #   for testing, assertion values depend on if we use game_team_csv or game_csv
  #
  #   assert_equal 3, @stat_tracker.biggest_team_blowout(17) #using game_team_stats_fixture.csv
  #   assert_equal 3, @stat_tracker.worst_loss(17) #using game_team_stats_fixture.csv
  # end
  #
  # def test_teams_head_to_head_record_is_shown_versus_a_specific_opponent
  #   # expected = Hash
  #
  #   assert_equal ({wins: 3, loses: 3}), @stat_tacker.head_to_head(17, 16) #two arguments
  #   #head_to_head method not shown with an argument
  #   #but may be a good idea if we specify by opponent
  # end
  #
  # def test_teams_seasonal_summary_is_shown_for_each_season_it_has_played
  #   # each season, a hash with two keys (:preseason, :regular_season)
  #   # each key points to a hash with following keys => :win_percentage,
  #   #:total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against
  #   expected = Hash
  #
  #   assert_equal expected, @stat_tracker.seasonal_summary(17)
  # end

end
