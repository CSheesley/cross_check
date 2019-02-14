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
    assert_equal expected, @st.biggest_bust(season_id)
    assert_equal expected, @st.biggest_suprise(season_id)
  end
  #
  # def test_best_and_worst_coach_by_win_percentage_for_season_are_shown
  #   skip
  #   expected = String
  #   assert_equal expected, @st.winningest_coach(season_id)
  #   assert_equal expected, @st.worst_coach(season_id)
  # end
  #
  # def test_most_and_least_accurate_teams_of_season_are_shown
  #   skip
  #   expected = String
  #   assert_equal expected, @st.most_accurate_team(season_id)
  #   assert_equal expected, @st.least_accurate_team((season_id)
  # end
  #
  # def test_most_and_least_hitting_teams_of_season_are_shown
  #   skip
  #   expected = String
  #   assert_equal expected, @st.most_hits(season_id)
  #   assert_equal expected, @st.least_hits(season_id)
  # end
  #
  # def test_percentage_of_goals_which_were_power_play_goals_for_season_are_shown
  #   skip
  #   expected = Float (nearest_100th)
  #   assert_equal expected, @st.power_play_goal_percentage(season_id)
  # end
end
