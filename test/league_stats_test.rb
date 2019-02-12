require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_stats'

class LeagueStats < Minitest::Test
  # def setup
  # end

  def test_league_stats_exists
    assert_instance_of LeagueStats, leaguestats
  end 

  def test_league_stats_has_teams_and_can_count_teams
    assert_equal expected, leaguestats.teams
    assert_equal expected, leaguestats.teams.size 
  end 

  def test_league_stats_can_return_best_and_worst_offenses
    assert_equal expected, leaguestats.best_offense
    assert_equal expected, leaguestats.worst_offense
  end 

  def test_league_stats_can_return_best_and_worst_defenses
    assert_equal expected, leaguestats.best_defense
    assert_equal expected, leaguestats.worst_defense
  end 

  def test_league_stats_can_return_lowest_and_highest_scoring_visitor_teams
    assert_equal expected, leaguestats.lowest_scoring_visitor
    assert_equal expected, leaguestats.highest_scoring_visitor
  end 

  def test_league_stats_can_return_lowest_and_highest_scoring_home_teams
    assert_equal expected, leaguestats.lowest_scoring_home_team
    assert_equal expected, leaguestats.highest_scoring_home_team
  end 

  def test_league_stats_can_return_winningest_team
    assert_equal expected, leaguestats.winningest_team
  end 
  
  def test_league_stats_can_return_worst_and_best_team_fans
    assert_equal expected, leaguestats.worst_fans
    assert_equal expected, leaguestats.best_fans
  end 
end 