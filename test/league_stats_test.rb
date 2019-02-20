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



  def test_league_stats_has_teams_and_can_count_teams
    assert_equal 33, @st.count_of_teams
    #with fixture file version of method
  end

  def test_league_stats_can_return_best_and_worst_offenses
    assert_equal "Bruins", @st.best_offense
    assert_equal "Penguins", @st.worst_offense
  end

  def test_league_stats_can_return_best_and_worst_defenses
    assert_equal "Bruins", @st.best_defense
    assert_equal "Rangers", @st.worst_defense
  end

  def test_league_stats_can_return_lowest_and_highest_scoring_visitor_teams
    assert_equal "Penguins", @st.highest_scoring_visitor
    assert_equal "Islanders", @st.lowest_scoring_visitor
  end

  def test_league_stats_can_return_lowest_and_highest_scoring_home_teams
    assert_equal "Islanders", @st.highest_scoring_home_team
    assert_equal "Penguins", @st.lowest_scoring_home_team
  end

  def test_league_stats_can_return_winningest_team
    assert_equal "Bruins", @st.winningest_team
  end

  def test_league_stats_can_return_worst_and_best_team_fans
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal "Bruins", st.best_fans
    assert_equal [], st.worst_fans
  end
end
