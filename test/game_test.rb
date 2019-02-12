require "./test/test_helper"

class GameTest < Minitest::Test

  def setup
    @game = Game.new(game_id: 2012030167,season: 20122013, type: "P",date_time: 2013-05-13,away_team_id: 17, home_team_id: 24, away_goals: 3, home_goals: 2, outcome: "away win REG", home_rink_side_start: "left", venue: "Honda Center", venue_link: "/api/v1/venues/null", venue_time_zone_id: "America/Los_Angeles", venue_time_zone_offset: -7, venue_time_zone_tz: "PDT")
  end


  def test_game_exists
    assert_instance_of Game, @game
  end


  def test_game_has_game_id
    assert_equal 2012030167, @game.game_id
  end


  def test_game_has_season
    assert_equal 20122013 , @game.season
  end


  def test_game_has_type
    assert_equal "P" , @game.type
  end


  def test_game_has_date_time
    assert_equal 2013-05-13 , @game.date_time
  end


  def test_game_has_away_team_id
    assert_equal 17 , @game.away_team_id
  end


  def test_game_has_home_team_id
    assert_equal 24 , @game.home_team_id
  end


  def test_game_has_away_goals
    assert_equal 3 , @game.away_goals
  end


  def test_game_has_home_goals
    assert_equal 2, @game.home_goals
  end


  def test_game_has_outcome
    assert_equal "away win REG" , @game.outcome
  end


  def test_game_has_home_rink_side_start
    assert_equal "left" , @game.home_rink_side_start
  end


  def test_game_has_venue
    assert_equal "Honda Center" , @game.venue
  end


  def test_game_has_venue_link
    assert_equal "/api/v1/venues/null" , @game.venue_link
  end


  def test_game_has_venue_time_zone_id
    assert_equal "America/Los_Angeles" , @game.venue_time_zone_id
  end


  def test_game_has_venue_time_zone_offset
    assert_equal -7 , @game.venue_time_zone_offset
  end


  def test_game_has_venue_time_zone_tz
    assert_equal "PDT" , @game.venue_time_zone_tz
  end
end