class SeasonStatsTest < Minitest::Test
  def setup
    @game_path = "./data/game_stats_w_reg.csv"
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_same_as_games.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_biggest_bust_and_suprise_of_season_is_shown
    assert_equal "Bruins", @st.biggest_suprise("20122013")
    assert_equal "Rangers", @st.biggest_bust("20122013")
  end
  
  def test_best_and_worst_coach_by_win_percentage_for_season_are_shown
    assert_equal "Claude Julien", @st.winningest_coach("20122013")
    assert_equal "John Tortorella", @st.worst_coach("20122013")
  end
  
  def test_most_and_least_accurate_teams_of_season_are_shown
    assert_equal "Bruins", @st.most_accurate_team("20122013")
    assert_equal "Rangers", @st.least_accurate_team("20122013")
  end

  def test_can_find_most_in_season
    assert_equal "Rangers", @st.find_most_or_least_for_season("20122013", "hits", "most")
    assert_equal "Bruins", @st.find_most_or_least_for_season("20122013", "accuracy", "most")
  end

  def test_can_find_least_in_season
    assert_equal "Bruins", @st.find_most_or_least_for_season("20122013","hits","least")
    assert_equal "Rangers", @st.find_most_or_least_for_season("20122013","accuracy", "least")
  end

  def test_most_and_least_hitting_teams_of_season_are_shown
    assert_equal "Rangers", @st.most_hits("20122013")
    assert_equal "Bruins", @st.least_hits("20122013")
  end

  def test_can_convert_game_id_to_season
    assert_equal "20122013", @st.game_id_to_season("2012030221")
  end

  def test_percentage_of_power_play_goals_for_season
    assert_equal 21.43, @st.power_play_goal_percentage("20122013")
  end
end
