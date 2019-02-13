require "./test/test_helper"

class LeagueStatsTest < Minitest::Test
  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end
  #
  def test_league_stats_exists
    assert_instance_of StatTracker, @st
  end
  #
  def test_league_stats_has_teams_and_can_count_teams
    assert_equal 33, @st.count
  end
  #
  # def test_league_stats_can_return_best_and_worst_offenses
  #   assert_equal expected, @st.best_offense
  #   assert_equal expected, @st.worst_offense
  # end
  #
  # def test_league_stats_can_return_best_and_worst_defenses
  #   assert_equal expected, @st.best_defense
  #   assert_equal expected, @st.worst_defense
  # end
  #
  # def test_league_stats_can_return_lowest_and_highest_scoring_visitor_teams
  #   assert_equal expected, @st.lowest_scoring_visitor
  #   assert_equal expected, @st.highest_scoring_visitor
  # end
  #
  # def test_league_stats_can_return_lowest_and_highest_scoring_home_teams
  #   assert_equal expected, @st.lowest_scoring_home_team
  #   assert_equal expected, @st.highest_scoring_home_team
  # end
  #
  # def test_league_stats_can_return_winningest_team
  #   assert_equal expected, @st.winningest_team
  # end
  #
  # def test_league_stats_can_return_worst_and_best_team_fans
  #   assert_equal expected, @st.worst_fans
  #   assert_equal expected, @st.best_fans
  # end
end
