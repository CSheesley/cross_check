require "./test/test_helper"
require "csv"

class TeamRepoTest < MiniTest::Test
  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_team_repo_exists
    assert_instance_of TeamRepo, @st.teams
  end

  def test_team_repo_has_teams
    assert_equal 30, @st.teams.repo.count
  end

  def test_team_repo_knows_parent
    assert_equal StatTracker, @st.teams.parent.class
  end 
end