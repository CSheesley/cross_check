require "./test/test_helper"

class TeamStatsTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture_corey.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_team_info_can_be_shown_in_a_hash_of_six_attributes
    expected = {
      "team_id" => 17,
      "franchise_id" => 12,
      "short_name" => "Detroit",
      "team_name" => "Red Wings",
      "abbreviation" => "DET",
      "link" => "/api/v1/teams/17"
    }
    assert_equal expected, @stat_tracker.team_info(17)
  end

  def test_all_games_played_can_be_gathered
    assert_equal 6, @stat_tracker.all_games_played(17).count
  end

  def test_all_wins_all_time_can_be_gathered_in_a_list
    assert_instance_of Array, @stat_tracker.all_wins_by_team(17)
    assert_equal 2, @stat_tracker.all_wins_by_team(17).count
  end

  def test_all_losses_all_time_can_be_gathered_in_a_list
    assert_instance_of Array, @stat_tracker.all_losses_by_team(17)
    assert_equal 4, @stat_tracker.all_losses_by_team(17).count
  end

  def test_all_seasons_played_by_a_team_can_be_added_to_a_list
    assert_equal [2011, 2012], @stat_tracker.all_seasons(17)
  end

  def test_teams_best_and_worst_season_based_on_win_percentage_can_be_shown
    #original expected = Integer
    #spec harness now says needs to convert to string "20122013"
    assert_equal 2012, @stat_tracker.best_season(17) # => "20122013"
    assert_equal 2011, @stat_tracker.worst_season(17) # => "20112012"
  end

  def test_teams_average_win_percentage_of_all_games_is_shown
    assert_equal 0.25, @stat_tracker.average_win_percentage(17)
  end

  def test_teams_highest_and_lowest_number_of_goals_in_a_single_game_is_shown
    assert_equal 4, @stat_tracker.most_goals_scored(17)
    assert_equal 0, @stat_tracker.fewest_goals_scored(17)
  end

  def test_all_wins_and_losses_for_a_team_can_be_shown
    assert_equal 2, @stat_tracker.all_wins_by_team(17).count
    assert_equal 4, @stat_tracker.all_losses_by_team(17).count
  end

  def test_teams_biggest_blowout_win__and_worst_loss_by_goal_differential_is_shown
    @game_path = './data/game_fixture_manually_built.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture_corey.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    @st = StatTracker.from_csv(@locations)

    assert_equal 3, @st.biggest_team_blowout(17)
    assert_equal 5, @st.worst_loss(17)
  end

  def test_teams_head_to_head_record_is_shown_versus_a_specific_opponent
    @game_path = './data/game_fixture_opponent_testing.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture_opponent_testing.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    @st = StatTracker.from_csv(@locations)
    expected = ({"Predators"=>0.67, "Maple Leafs"=>0.5})

    assert_equal expected, @st.head_to_head(17)
  end

  def test_all_wins_and_all_games_can_be_grouped_by_opponent
    @game_path = './data/game_fixture_opponent_testing.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture_opponent_testing.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    @st = StatTracker.from_csv(@locations)
    expected_1 = ({"Predators"=>2, "Maple Leafs"=>1})
    expected_2 = ({"Predators"=>3, "Maple Leafs"=>2})

    assert_equal expected_1, @st.all_wins_vs_opponent(17)
    assert_equal expected_2, @st.all_games_vs_opponent(17)
  end

  def test_rival_and_favorite_opponent_can_be_shown
    @game_path = './data/game_fixture_opponent_testing.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture_opponent_testing.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    @st = StatTracker.from_csv(@locations)

    assert_equal "Predators", @st.favorite_opponent(17)
    assert_equal "Maple Leafs", @st.rival(17)
  end

  # def test_teams_seasonal_summary_is_shown_for_each_season_it_has_played
  #   # each season, a hash with two keys (:preseason, :regular_season)
  #   # each key points to a hash with following keys => :win_percentage,
  #   #:total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against
  #   expected = Hash
  #
  #   assert_equal expected, @stat_tracker.seasonal_summary(17)
  # end

end
