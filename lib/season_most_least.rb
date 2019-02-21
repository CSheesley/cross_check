module SeasonMostLeast
  def find_most_or_least_for_season(season, attribute, most_or_least) #bananas helper
    game_teams = (all_game_teams_for_season(season).values).flatten
    by_team = game_teams.group_by do |game_team|
      game_team.team_id
    end
    return_hash = {}
    return_team = nil
    sum = 0
    if most_or_least == "most"
      if attribute == "hits"
        by_team.each do |team,game_teams|
          sum = game_teams.sum do |game_team|
            game_team.hits
          end
          return_hash[team] = sum
        end
        return_team = return_hash.key(return_hash.values.max)
        team_id_swap(return_team)
      elsif attribute == "accuracy"
        by_team.each do |team,game_teams|
          shots = game_teams.sum do |game_team|
            game_team.shots
          end
          goals = game_teams.sum do |game_team|
            game_team.goals
          end
          ratio = goals / shots.to_f
          return_hash[team] = ratio
        end
        return_team = return_hash.key(return_hash.values.max)
        team_id_swap(return_team)
      end
    else
      if attribute == "hits"
        by_team.each do |team,game_teams|
          sum = game_teams.sum do |game_team|
            game_team.hits
          end
          return_hash[team] = sum
        end
        return_team = return_hash.key(return_hash.values.min)
        team_id_swap(return_team)
      elsif attribute == "accuracy"
        by_team.each do |team,game_teams|
          shots = game_teams.sum do |game_team|
            game_team.shots
          end
          goals = game_teams.sum do |game_team|
            game_team.goals
          end
          ratio = goals / shots.to_f
          return_hash[team] = ratio
        end
        return_team = return_hash.key(return_hash.values.min)
        team_id_swap(return_team)
      end
    end
  end
end
