require "./lib/team_repo"

class Team
  attr_reader :team_id, 
    :franchise_id, 
    :short_name, 
    :team_name, 
    :abbreviation,
    :link 

  def initialize(team_info, parent)
    @team_id      = team_info[:team_id].to_i
    @franchise_id = team_info[:franchise_id].to_i 
    @short_name   = team_info[:short_name] 
    @team_name    = team_info[:team_name] 
    @abbreviation = team_info[:abbreviation] 
    @link         = team_info[:link]
    @parent       = parent 
  end 
end 

