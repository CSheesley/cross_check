require "./test/test_helper"

class TeamRepoTest < MiniTest::Test
  def setup
    @team_repo = TeamRepo.new('./data/team_info.csv')
  end

  def test_team_repo_exists
    assert_instance_of TeamRepo, @team_repo
  end

  def test_team_repo_has_teams
    assert_equal 33, @team_repo.repo.count
  end
end
