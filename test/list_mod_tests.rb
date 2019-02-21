require "./test/test_helper"

class ListModTest < Minitest::Test
  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end


  def test_stat_tracker_can_swap_team_and_team_id
    assert_equal "Bruins", @st.team_id_swap("6")
  end

  def test_stat_tracker_can_list_all_opponent_game_teams
    assert_equal 9, @st.get_all_opponents_game_team_data("6").count
    assert_equal "2012030221", @st.get_all_opponents_game_team_data("6").first.game_id
  end

  def test_stat_tracker_can_find_total_points_for_team
    assert_equal 28, @st.total_points_for_team("6")
  end

  def test_stat_tracker_can_find_total_points_against
    assert_equal 12, @st.total_points_against("Bruins")
  end

  def test_stat_tracker_can_list_won_games_for_team
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 3, st.won_games("6").count
    assert_equal "2012030221", st.won_games("6").first.game_id
  end

  def test_stat_tracker_can_list_regular_games
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 2, st.regular_games_by_season("20122013").count
    assert_equal "2012030224", st.regular_games_by_season("20122013").first.game_id
  end

  def test_stat_tracker_can_list_postseason_games
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 3, st.preseason_games_by_season("20122013").count
    assert_equal "2012030221", st.preseason_games_by_season("20122013").first.game_id
  end

  def test_stat_tracker_can_calculate_win_percentage
    assert_equal 0.20, @st.win_percentage("3")
  end
end
