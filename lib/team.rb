class Team
  attr_reader :team_id, :franchise_id, :short_name, :team_name, :abbreviation 

  def initialize(team_info)
    @team_id      = team_info[:team_id].to_i
    @franchise_id = team_info[:franchise_id].to_i #on the csv, it is #franchiseID
    @short_name   = team_info[:short_name] #on the csv, it is shortName -- should we change short_name to something else or is that really what it's supposed ot be called? 
    @team_name    = team_info[:team_name] #csv, teamName - I don't think these should matter, right? 
    @abbreviation = team_info[:abbreviation] 
  end 
end 

# csv file has "link" as last info - see ex below, do I include? 
# "1","23","New Jersey","Devils","NJD","/api/v1/teams/1"