require "./test/test_helper"

class GameTeamTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_game_team_exists
    assert_instance_of GameTeam, @st.game_teams.repo.first
  end

  def test_game_team_has_a_game_id_and_a_team_id
    assert_equal 2012030221, @st.game_teams.repo.first.game_id
    assert_equal 3, @st.game_teams.repo.first.team_id
  end

  def test_game_team_can_show_home_or_away_status
    assert_equal "away", @st.game_teams.repo.first.home_or_away
  end

  def test_game_team_can_show_if_team_won_game
    assert_equal false, @st.game_teams.repo.first.won?
  end

  def test_if_game_team_game_was_finished_in_regulation_or_overtime
    assert_equal "OT", @st.game_teams.repo.first.settled_in
  end

  def test_head_coach_of_game_team_is_shown
    assert_equal "John Tortorella", @st.game_teams.repo.first.head_coach
  end

  def test_number_of_goals_for_game_team_is_shown
    assert_equal 2, @st.game_teams.repo.first.goals
  end

  def test_number_of_shots_for_game_team_is_shown
    assert_equal 35, @st.game_teams.repo.first.shots
  end

  def test_number_of_hits_for_game_team_is_shown
    assert_equal 44, @st.game_teams.repo.first.hits
  end

  def test_number_penalty_infraction_minutes_for_game_team_is_shown
    assert_equal 8, @st.game_teams.repo.first.pim
  end

  def test_number_of_power_play_opportunities_per_game_team_are_shown
    assert_equal 3, @st.game_teams.repo.first.power_play_chances
  end

  def test_number_of_game_team_power_play_goals_are_shown
    assert_equal 0, @st.game_teams.repo.first.power_play_goals
  end

  def test_game_team_face_off_win_percentage_is_shown
    assert_equal 44.8, @st.game_teams.repo.first.face_off_win_percentage
  end

  def test_number_of_game_team_giveways_and_takeaways_are_shown
    assert_equal 17, @st.game_teams.repo.first.giveaways
    assert_equal 7, @st.game_teams.repo.first.takeaways
  end
end
