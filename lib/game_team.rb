class GameTeam
  attr_reader :game_id,
    :team_id,
    :home_or_away,
    :won,
    :head_coach,
    :goals,
    :shots,
    :hits,
    :power_play_chances,
    :power_play_goals

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @home_or_away = info[:hoa]
    @won = info[:won]
    @head_coach = info[:head_coach]
    @goals = info[:goals].to_i
    @shots = info[:shots].to_i
    @hits = info[:hits].to_i
    @power_play_chances = info[:powerplayopportunities].to_i
    @power_play_goals = info[:powerplaygoals].to_i
  end

  def won?
    if @won == "TRUE"
      return true
    else
      return false
    end
  end
end
