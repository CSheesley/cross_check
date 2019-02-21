class Game
  attr_reader :game_id, 
    :season, 
    :type, 
    :away_team_id, 
    :home_team_id, 
    :away_goals, 
    :home_goals, 
    :outcome

  def initialize(info)
    @game_id      = info[:game_id]
    @season       = info[:season]
    @type         = info[:type]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals   = info[:away_goals].to_i
    @home_goals   = info[:home_goals].to_i
    @outcome      = info[:outcome]
  end
end
