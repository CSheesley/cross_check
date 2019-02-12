require "./test/test_helper"
require "./lib/game_repo"
require "csv"

class GameRepoTest < MiniTest::Test
  def setup
    @game_repo = GameRepo.new
    binding.pry
  end


  def test_game_repo_exists
    assert_instance_of GameRepo, @game_repo
  end
end
