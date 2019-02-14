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

  def test_has_of_teams_and_id
    assert_equal ({1 => "Devils",
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
      54  => "Golden Knights"}), @st.make_team_id_hash
  end
  #
  def test_league_stats_has_teams_and_can_count_teams
    assert_equal 5, @st.count_of_teams
    #with fixture file version of method
  end

  def test_league_stats_can_swap_team_and_team_id
    assert_equal 6, @st.team_id_swap("Bruins")
    assert_equal "Bruins", @st.team_id_swap(6)
    assert_equal 6, @st.team_id_swap("bruins")
  end

  def test_league_stats_can_list_all_game_teams_for_team
    assert_equal 9, @st.get_all_game_teams_for_team("Bruins").count
    assert_equal 2012030221, @st.get_all_game_teams_for_team("Bruins").first.game_id
  end

  def test_league_stats_can_list_all_opponent_game_teams
    assert_equal 9, @st.get_all_opponents_game_team_data("Bruins").count
    assert_equal 2012030221, @st.get_all_opponents_game_team_data("Bruins").first.game_id
  end
  #
  def test_league_stats_can_find_total_goals_for_team
    assert_equal 28, @st.total_points_for_team("Bruins")
  end

  def test_league_stats_can_find_total_goals_against
    assert_equal 12, @st.total_points_against("Bruins")
  end

  def test_league_stats_can_make_list_of_teams
    assert_equal ["Rangers", "Bruins", "Penguins", "Red Wings", "Blackhawks"], @st.array_of_teams
  end

  def test_league_stats_can_make_list_of_team_ids
    assert_equal [3, 6, 5, 17, 16], @st.array_of_team_ids
  end

  def test_league_stats_can_return_best_and_worst_offenses
    assert_equal "Bruins", @st.best_offense
    assert_equal "Penguins", @st.worst_offense
  end
  #
  def test_league_stats_can_return_best_and_worst_defenses
    assert_equal "Bruins", @st.best_defense
    assert_equal "Rangers", @st.worst_defense
  end
  #
  def test_league_stats_can_return_lowest_and_highest_scoring_visitor_teams
    assert_equal "Bruins", @st.highest_scoring_visitor
    assert_equal "Penguins", @st.lowest_scoring_visitor
  end
  #
  def test_league_stats_can_return_lowest_and_highest_scoring_home_teams
    assert_equal "Penguins", @st.lowest_scoring_home_team
    assert_equal "Bruins", @st.highest_scoring_home_team
  end
  #
  def test_league_stats_can_return_winningest_team
    skip
    assert_equal "Bruins", @st.winningest_team
  end
  #
  def test_league_stats_can_return_worst_and_best_team_fans
    skip
    assert_equal "Bruins", @st.best_fans
    assert_equal [], @st.worst_fans
  end
end
