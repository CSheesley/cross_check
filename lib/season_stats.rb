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



  def most_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "most")
    # min_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def least_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "least")
    # max_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def most_hits(season)
    find_most_or_least_for_season(season, "hits", "most")
    #team with most hits
    #IN GIVEN SEASON
    #string of team name
  end


  def find_games_by_season(season)
    @game_teams.repo.find_all do |game_team|
      game_id_to_season(game_team.game_id) == season
    end
  end

  def find_most_or_least_for_season(season, attribute, most_or_least)
    list = find_games_by_season(season)
    team = nil
    most = 0
    sum = 0
    least = 5000 #what should I put here
    if most_or_least == "most"
      if attribute == "hits"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          sum = games.sum do |game|
            game.hits
          end
          if sum > most
            most = sum
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      elsif attribute == "accuracy"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          shots = games.sum do |game|
            game.shots
          end
          goals = games.sum do |game|
            game.goals
          end
          ratio = shots / goals.to_f
          if ratio > most
            least = ratio
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      end
    else
      if attribute = "hits"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          sum = games.sum do |game|
            game.hits
          end
          if sum < least
            least = sum
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      elsif attribute == "accuracy"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          shots = games.sum do |game|
            game.shots
          end
          goals = games.sum do |game|
            game.goals
          end
          ratio = shots / goals.to_f
          if ratio < least
            least = ratio
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      end
    end
  end


  def least_hits(season)
    find_most_or_least_for_season(season,"hits","least")
    #team with fewest hits
    #IN GIVEN SEASON
    #string of team name
  end



  def game_id_to_season(game_id)
    game_team = @games.repo.find do |game|
      game.game_id == game_id
    end
    game_team.season
  end



  def power_play_goal_percentage(season)
    list = find_games_by_season(season)
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
