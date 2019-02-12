require "./test/test_helper"
require "csv"

class GameTeamRepoTest < MiniTest::Test
  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end

  def test_game_team_repo_exists
    assert_instance_of GameTeamRepo, @st.game_teams
  end

  def test_game_team_repo_has_game_teams
    assert_equal 30, @st.game_teams.repo.count
  end

  def test_it_knows_who_its_parent_is
    assert_equal StatTracker, @st.game_teams.parent.class
  end
end
