require "./test/test_helper"

class TeamTest < Minitest::Test
  def setup
    team_info = {team_id: "6", 
      franchise_id: "6", 
      short_name: "Boston", 
      team_name: "Bruins", 
      abbreviation: "BOS",
      link: "/api/v1/teams/6"}

    @team = Team.new(team_info)
    # @game_path = './data/game_fixture.csv'
    # @team_path = './data/team_info.csv'
    # @game_teams_path = './data/game_team_stats_fixture.csv'
    # @locations = {games: @game_path,
    #               teams: @team_path,
    #               game_teams: @game_teams_path}
    # @st = StatTracker.from_csv(@locations)
  end

  def test_team_exists
    assert_instance_of Team, @st.teams
  end

  def test_team_has_team_id
    assert_equal 6, @st.teams.first.team_id
  end

  def test_team_has_franchise_id
    assert_equal 6, @st.teams.franchise_id
  end

  def test_team_has_short_name
    assert_equal "Boston", @st.teams.short_name
  end

  def test_team_has_team_name
    assert_equal "Bruins", @st.teams.team_name
  end

  def test_team_has_abbreviation
    assert_equal "BOS", @st.teams.abbreviation
  end

  def test_team_has_link
    assert_equal "/api/v1/teams/6", @st.teams.link
  end

  def test_team_knows_who_parent_is
    assert_equal TeamRepo, @st.teams.repo.first.parent.class
  end

  def test_team_knows_who_grandparent_is
    assert_equal StatTracker, @st.teams.parent
  end
end
