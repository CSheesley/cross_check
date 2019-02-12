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

  def initialize(info)
    @game_id = info[:game_id].to_i
    @team_id = info[:team_id].to_i
    @home_or_away = info[:home_or_away]
    @won = info[:won]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @hits = info[:hits]
    @pim = info[:pim]
    @power_play_chances = info[:power_play_chances]
    @power_play_goals = info[:power_play_goals]
    @face_off_win_percentage = info[:face_off_win_percentage]
    @giveaways = info[:giveaways]
    @takeaways = info[:takeaways]
  end

  def won?
    @won
  end
end
