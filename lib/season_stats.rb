module SeasonStats

  def biggest_bust
    # max (preseason win %) - (regular win %) => decrease
    #FOR GIVEN SEASON
    #string of team name
  end


  def biggest_suprise
    #max (regular win %) - (preseason win %) => increase
    #FOR GIVEN SEASON
    #string of team name
  end


  def winningest_coach
    #coach of best win % for SEASON
    #string of coach name
  end


  def worst_coach
    #coach of worst win % for SEASON
    #string of coach name
  end



  def most_accurate_team
    # min_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def least_accurate_team
    # max_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def most_hits
    #team with most hits
    #IN GIVEN SEASON
    #string of team name
  end


  def least_hits
    #team with fewest hits
    #IN GIVEN SEASON
    #string of team name
  end

  def game_id_to_season(game_id)
    game = @games.repo.find do |game|
      game.game_id == game_id
    end
    game.season
  end

  def power_play_goal_percentage(season)
    list = @game_teams.repo.find_all do |game_team|
      game_id_to_season(game_team.game_id) == season
    end
    pp_goals = list.reduce(0) do |sum, game_team|
      sum += game_team.power_play_goals
    end
    pp_goals = pp_goals.to_f
    total_goals = list.reduce(0) do |sum, game_team|
      sum += (game_team.goals)
    end
    (100 * pp_goals / total_goals).round(2)
  end

end
