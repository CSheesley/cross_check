require "./test/test_helper"

class SeasonStatsTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_biggest_bust_and_suprise_of_season_is_shown
    skip
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_team_stats_fixture.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st2 = StatTracker.from_csv(locations)
    assert_equal "Rangers", st2.biggest_bust(20122013)
    assert_equal "Islanders", st2.biggest_suprise(20122013)
  end
  #
  def test_best_and_worst_coach_by_win_percentage_for_season_are_shown
    skip
    assert_equal "Claude Julien", @st.winningest_coach(20122013)
    assert_equal "Dan Bylsma", @st.worst_coach(20122013)
  end
  #
  def test_most_and_least_accurate_teams_of_season_are_shown
    skip
    assert_equal "Red Wings", @st.most_accurate_team(20122013)
    assert_equal "Penguins", @st.least_accurate_team(20122013)
  end
  #
  def test_most_and_least_hitting_teams_of_season_are_shown
    skip
    assert_equal "Bruins", @st.most_hits(20122013)
    assert_equal "Blackhawks", @st.least_hits(20122013)
  end
  #

  def test_can_convert_game_id_to_season
    assert_equal 20122013, @st.game_id_to_season(2012030111)
  end

  def test_percentage_of_power_play_goals_for_season
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st2 = StatTracker.from_csv(locations)

    assert_equal 23.08, st2.power_play_goal_percentage(20122013)
  end
end
