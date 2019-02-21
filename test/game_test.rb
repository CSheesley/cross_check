class GameTest < Minitest::Test
  def setup
    @game = Game.new(
      {
        game_id: "2012030167",
        season: "20122013",
        type: "P",
        away_team_id: "17",
        home_team_id: "24",
        away_goals: "3",
        home_goals: "2",
        outcome: "away win REG"
      }
    )
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  def test_game_has_game_id
    assert_equal "2012030167", @game.game_id
  end

  def test_game_has_season
    assert_equal "20122013", @game.season
  end

  def test_game_has_type
    assert_equal "P", @game.type
  end

  def test_game_has_away_team_id
    assert_equal "17", @game.away_team_id
  end

  def test_game_has_home_team_id
    assert_equal "24", @game.home_team_id
  end

  def test_game_has_away_goals
    assert_equal 3, @game.away_goals
  end

  def test_game_has_home_goals
    assert_equal 2, @game.home_goals
  end

  def test_game_has_outcome
    assert_equal "away win REG", @game.outcome
  end
end
