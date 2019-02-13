class GameTeam
  attr_reader :game_id,
    :team_id,
    :home_or_away,
    :settled_in,
    :head_coach,
    :goals,
    :shots,
    :hits,
    :pim,
    :power_play_chances,
    :power_play_goals,
    :face_off_win_percentage,
    :giveaways,
    :takeaways

  def initialize(info, parent)
    @game_id = info[:game_id].to_i
    @team_id = info[:team_id].to_i
    @home_or_away = info[:hoa]
    @won = info[:won]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals].to_i
    @shots = info[:shots].to_i
    @hits = info[:hits].to_i
    @pim = info[:pim].to_i
    @power_play_chances = info[:powerplayopportunities].to_i
    @power_play_goals = info[:power_play_goals].to_i
    @face_off_win_percentage = info[:faceoffwinpercentage].to_f.round(2)
    @giveaways = info[:giveaways].to_i
    @takeaways = info[:takeaways].to_i

    @parent = parent
  end

  def won?
    if @won == "TRUE"
      return true
    else
      return false
    end
  end
end
