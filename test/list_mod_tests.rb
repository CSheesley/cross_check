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

  def test_hash_of_teams_and_id
    expected = ({1 => "Devils",
      2  => "Islanders",
      3  => "Rangers",
      4  => "Flyers",
      5  => "Penguins",
      6  => "Bruins",
      7  => "Sabres",
      8  => "Canadiens",
      9  => "Senators",
      10  => "Maple Leafs",
      11  => "Thrashers",
      12  => "Hurricanes",
      13  => "Panthers",
      14  => "Lightning",
      15  => "Capitals",
      16  => "Blackhawks",
      17  => "Red Wings",
      18  => "Predators",
      19  => "Blues",
      20  => "Flames",
      21  => "Avalanche",
      22  => "Oilers",
      23  => "Canucks",
      24  => "Ducks",
      25  => "Stars",
      26  => "Kings",
      27  => "Coyotes",
      28  => "Sharks",
      29  => "Blue Jackets",
      30  => "Wild",
      52  => "Jets",
      53  => "Coyotes",
      54  => "Golden Knights"})
      assert_equal expected, @st.make_team_id_hash
  end


  def test_stat_tracker_can_make_list_of_teams
    assert_equal ["Rangers", "Bruins", "Penguins", "Red Wings", "Blackhawks"], @st.array_of_teams
  end

  def test_stat_tracker_can_make_list_of_team_ids
    assert_equal [3, 6, 5, 17, 16], @st.array_of_team_ids
  end

  def test_stat_tracker_can_swap_team_and_team_id
    assert_equal 6, @st.team_id_swap("Bruins")
    assert_equal "Bruins", @st.team_id_swap(6)
    assert_equal 6, @st.team_id_swap("bruins")
  end


  def test_stat_tracker_can_list_all_game_teams_for_team
    assert_equal 9, @st.get_all_game_teams_for_team("Bruins").count
    assert_equal 2012030221, @st.get_all_game_teams_for_team("Bruins").first.game_id
  end

  def test_stat_tracker_can_list_all_opponent_game_teams
    assert_equal 9, @st.get_all_opponents_game_team_data("Bruins").count
    assert_equal 2012030221, @st.get_all_opponents_game_team_data("Bruins").first.game_id
  end

  def test_stat_tracker_can_list_all_games_for_team
    assert_equal 8, @st.get_all_games("Rangers").count
    assert_instance_of Game, @st.get_all_games("Rangers").first
  end

  def test_stat_tracker_can_list_all_game_teams_for_season
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 10, st.find_game_teams_by_season(20122013).count
    assert_instance_of GameTeam, st.find_game_teams_by_season(20122013).first
  end

  def test_stat_tracker_can_list_all_games_for_season
    assert_equal 19, @st.find_games_by_season(20122013).count
    assert_instance_of Game, @st.find_games_by_season(20122013).first
  end


  def test_stat_tracker_can_find_total_points_for_team
    assert_equal 28, @st.total_points_for_team("Bruins")
  end

  def test_stat_tracker_can_find_total_points_against
    assert_equal 12, @st.total_points_against("Bruins")
  end


  def test_stat_tracker_can_get_all_home_games
    assert_equal 2, @st.get_team_home_games("Rangers").count
    assert_equal 2012030223, @st.get_team_home_games("Rangers").first.game_id
  end

  def test_stat_tracker_can_get_all_away_games
    assert_equal 3, @st.get_team_away_games("Rangers").count
    assert_equal 2012030221, @st.get_team_away_games("Rangers").first.game_id
  end


  def test_stat_tracker_can_list_won_game_teams_for_team
    assert_equal 8, @st.won_game_teams("Bruins").count
    assert_equal 2012030221, @st.won_game_teams("Bruins").first.game_id
  end

  def test_stat_tracker_can_list_lost_game_teams_for_team
    assert_equal 1, @st.lost_game_teams("Bruins").count
    assert_equal 2012030224, @st.lost_game_teams("Bruins").first.game_id
  end


  def test_stat_tracker_can_list_won_games_for_team
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 3, st.won_games("Bruins").count
    assert_equal 2012030221, st.won_games("Bruins").first.game_id
  end

  def test_stat_tracker_can_list_lost_games_for_team
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 2, st.lost_games("Bruins").count
    assert_equal 2012030222, st.lost_games("Bruins").first.game_id
  end



  def test_stat_tracker_can_list_regular_games
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 2, st.regular_games("Rangers").count
    assert_equal 2012030224, st.regular_games("Rangers").first.game_id
  end

  def test_stat_tracker_can_list_postseason_games
    game_path = "./data/game_stats_w_reg.csv"
    team_path = './data/team_info.csv'
    game_teams_path = 'data/game_team_stats_same_as_games.csv'
    locations = {games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path}
    st = StatTracker.from_csv(locations)
    assert_equal 3, st.postseason_games("Rangers").count
    assert_equal 2012030221, st.postseason_games("Rangers").first.game_id
  end


  def test_stat_tracker_can_calculate_win_percentage
    assert_equal 20.0, @st.win_percentage("Rangers",@st.get_all_game_teams_for_team("Rangers"))
  end

  def test_stat_tracker_can_calculate_loss_percentage
    assert_equal 80.0, @st.loss_percentage("Rangers", @st.get_all_game_teams_for_team("Rangers"))
  end
end
