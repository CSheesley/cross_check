require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/game_fixture.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_team_stats_fixture.csv'
    @locations = {games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path}

    game_1_info = ("2012030167","20122013","P",2013-05-13,"17","24",3,2,"away win REG","left","Honda Center","/api/v1/venues/null","America/Los_Angeles",-7,"PDT")
    game_2_info = ("2012030111","20122013","P",2013-05-01,"2","5",0,5,"home win REG","left","CONSOL Energy Center","/api/v1/venues/null","America/New_York",-4,"EDT")
    game_3_info = ("2012030112","20122013","P",2013-05-03,"2","5",4,3,"away win REG","left","CONSOL Energy Center","/api/v1/venues/null","America/New_York",-4,"EDT")
    game_1 = Game.new()
  end

  def test_stat_tracker_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end


  def test_stat_tracker_reads_csv
    @st = StatTracker.from_csv(@locations)
    assert_instance_of StatTracker, @st
  end

  def test_stat_tracker_makes_game_repo_when_initialized
    @st = StatTracker.from_csv(@locations)
    assert_instance_of GameRepo, @st.games
    assert_equal 30, @st.games.repo.count
    assert_equal 3, @st.games.repo.first.away_goals
  end

end 
  