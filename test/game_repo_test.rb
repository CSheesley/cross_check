require "./test/test_helper"

class GameRepoTest < MiniTest::Test
  def setup
    @game_repo = GameRepo.new('./data/game_fixture.csv')
  end


  def test_game_repo_exists
    assert_instance_of GameRepo, @game_repo
  end


  def test_game_repo_has_games
    assert_equal 30, @game_repo.repo.count
    assert_equal Array, @game_repo.repo.class
    assert_equal 3, @game_repo.repo.first.away_goals
  end
end
