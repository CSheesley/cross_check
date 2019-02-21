class GameTeamTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      won: "FALSE",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "35",
      hits: "44",
      powerplayopportunities: "3",
      powerplaygoals: "0",
      })
  end

  def test_game_team_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_game_team_has_a_game_id_and_team_id
    assert_equal "2012030221", @game_team.game_id
    assert_equal "3", @game_team.team_id
  end

  def test_game_team_can_show_home_or_away_status
    assert_equal "away", @game_team.home_or_away
  end

  def test_game_team_can_show_if_team_won_game
    assert_equal false, @game_team.won?
  end

  def test_head_coach_of_game_team_is_shown
    assert_equal "John Tortorella", @game_team.head_coach
  end

  def test_number_of_goals_for_game_team_is_shown
    assert_equal 2, @game_team.goals
  end

  def test_number_of_shots_for_game_team_is_shown
    assert_equal 35, @game_team.shots
  end

  def test_number_of_hits_for_game_team_is_shown
    assert_equal 44, @game_team.hits
  end

  def test_number_of_power_play_opportunities_per_game_team_are_shown
    assert_equal 3, @game_team.power_play_chances
  end

  def test_number_of_game_team_power_play_goals_are_shown
    assert_equal 0, @game_team.power_play_goals
  end
end
