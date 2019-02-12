require "./test/test_helper"
require "./lib/game_repo"
require "csv"

class GameRepoTest < MiniTest::Test
  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path}
    @st = StatTracker.from_csv(@locations)
  end


  def test_game_repo_exists
    assert_instance_of GameRepo, @st.games
  end


  def test_game_repo_has_games
    assert_equal 30, @st.games.repo.count
    assert_equal 3, @st.games.repo.first.away_goals
  end
end
