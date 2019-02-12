require "./test/test_helper"

class GameTeamTest < Minitest::Test

  def setup
    @instance_1 = GameTeam.new({
      game_id: "2012030221",
      team_id: "3",
      home_or_away: "away",
      won: FALSE,
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 35,
      hits: 44,
      pim: 8,
      power_play_chances: 3,
      power_play_goals: 0,
      face_off_win_percentage: 44.8,
      giveaways: 17,
      takeaways: 7
      })
  end

  def test_game_team_exists

    assert_instance_of GameTeam, @instance_1
  end

  def test_game_team_has_a_game_id

    assert_equal 2012030221, @instance_1.game_id
  end

  def test_game_team_has_a_team_id_number

    assert_equal 3, @instance_1.team_id
  end

  def test_game_team_can_show_home_or_away_status

    assert_equal "away", @instance_1.home_or_away
  end

  def test_game_team_can_show_if_team_won_game

    assert_equal false, @instance_1.won?
  end

  def test_if_game_team_game_was_finished_in_regulation_or_overtime

    assert_equal "OT", @instance_1.settled_in
  end

  def test_head_coach_of_game_team_is_shown

    assert_equal "John Tortorella", @instance_1.head_coach
  end

  def test_number_of_goals_for_game_team_is_shown

    assert_equal 2, @instance_1.goals
  end

  def test_number_of_shots_for_game_team_is_shown

    assert_equal 35, @instance_1.shots
  end

  def test_number_of_hits_for_game_team_is_shown

    assert_equal 44, @instance_1.hits
  end

  def test_number_penalty_infraction_minutes_for_game_team_is_shown

    assert_equal 8, @instance_1.pim
  end

  def test_number_of_power_play_opportunities_per_game_team_are_shown

    assert_equal 3, @instance_1.power_play_chances
  end

  def test_number_of_game_team_power_play_goals_are_shown

    assert_equal 0, @instance_1.power_play_goals
  end

  def test_game_team_face_off_win_percentage_is_shown

    assert_equal 44.8, @instance_1.face_off_win_percentage
  end

  def test_number_of_game_team_giveways_is_shown

    assert_equal 17, @instance_1.giveaways
  end

  def test_number_of_game_team_takeaways_is_shown
    
    assert_equal 7, @instance_1.takeaways
  end

end
