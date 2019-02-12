require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    team_info = {team_id: "6", 
      franchise_id: "6", 
      short_name: "Boston", 
      team_name: "Bruins", 
      abbreviation: "BOS",
      link: "/api/v1/teams/6"}
    @team = Team.new(team_info)
  end 

  def test_team_exists
    assert_instance_of Team, @team
  end 

  def test_team_has_team_id
    assert_equal 6, @team.team_id
  end 

  def test_team_has_franchise_id
    assert_equal 6, @team.franchise_id
  end 

  def test_team_has_short_name
    assert_equal "Boston", @team.short_name
  end 

  def test_team_has_team_name
    assert_equal "Bruins", @team.team_name
  end 

  def test_team_has_abbreviation
    assert_equal "BOS", @team.abbreviation
  end 

  def test_team_has_link
    assert_equal "/api/v1/teams/6", @team.link 
  end 
end 