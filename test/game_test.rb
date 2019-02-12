require "./test/test_helper"

class GameTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_game_knows_who_parent_is
    assert_equal GameRepo, @st.games.repo.first.parent.class
  end


  def test_game_exists
    assert_instance_of Game, @st.games.repo.first
  end


  def test_game_has_game_id
    assert_equal 2012030167, @st.games.repo.first.game_id
  end


  def test_game_has_season
    assert_equal 20122013, @st.games.repo.first.season
  end


  def test_game_has_type
    assert_equal "P", @st.games.repo.first.type
  end


  def test_game_has_date_time
    assert_equal "2013-05-13", @st.games.repo.first.date_time
  end


  def test_game_has_away_team_id
    assert_equal 17, @st.games.repo.first.away_team_id
  end


  def test_game_has_home_team_id
    assert_equal 24, @st.games.repo.first.home_team_id
  end


  def test_game_has_away_goals
    assert_equal 3, @st.games.repo.first.away_goals
  end


  def test_game_has_home_goals
    assert_equal 2, @st.games.repo.first.home_goals
  end


  def test_game_has_outcome
    assert_equal "away win REG", @st.games.repo.first.outcome
  end


  def test_game_has_home_rink_side_start
    assert_equal "left", @st.games.repo.first.home_rink_side_start
  end


  def test_game_has_venue
    assert_equal "Honda Center", @st.games.repo.first.venue
  end


  def test_game_has_venue_link
    assert_equal "/api/v1/venues/null", @st.games.repo.first.venue_link
  end


  def test_game_has_venue_time_zone_id
    assert_equal "America/Los_Angeles", @st.games.repo.first.venue_time_zone_id
  end


  def test_game_has_venue_time_zone_offset
    assert_equal -7, @st.games.repo.first.venue_time_zone_offset
  end


  def test_game_has_venue_time_zone_tz
    assert_equal "PDT", @st.games.repo.first.venue_time_zone_tz
  end
end
