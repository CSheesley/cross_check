require "./test/test_helper"

class GameTeamRepoTest < MiniTest::Test
  def setup
    @game_team_repo = GameTeamRepo.new('./data/game_team_stats_fixture.csv', "StatTracker")
  end

  def test_game_team_repo_exists
    assert_instance_of GameTeamRepo, @game_team_repo
  end

  def test_game_team_repo_has_game_teams
    assert_equal 30, @game_team_repo.repo.count
  end

  def test_it_knows_who_its_parent_is
    assert_equal "StatTracker", @game_team_repo.parent
  end
end
