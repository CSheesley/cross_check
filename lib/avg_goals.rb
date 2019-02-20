module AvgGoals
  # def average_away_goals_per_team #bananas helper
  #   avg_hash = {}
  #   hash_away_games_by_team.each do |team,games|
  #     sum = games.sum { |game| game.away_goals}
  #     avg_hash[team] = (sum.to_f / games.count)
  #   end
  #   avg_hash
  # end
  #
  # def average_home_goals_per_team #bananas helper
  #   avg_hash = {}
  #   hash_home_games_by_team.each do |team,games|
  #     sum = games.sum { |game| game.home_goals}
  #     avg_hash[team] = (sum.to_f / games.count)
  #   end
  #   avg_hash
  # end
  #
  # def average_goals(where,most_least) #bananas helper
  #   if where == "away" && most_least == "most"
  #     hash = average_away_goals_per_team
  #     highest_avg = 0
  #     best = nil
  #     hash.each do |team,average|
  #       if average > highest_avg
  #         highest_avg = average
  #         best = team
  #       end
  #     end
  #     team_id_swap(best)
  #   elsif where == "away" && most_least == "least"
  #     hash = average_away_goals_per_team
  #     lowest_avg = 50
  #     worst = nil
  #     hash.each do |team,average|
  #       if average < lowest_avg
  #         lowest_avg = average
  #         worst = team
  #       end
  #     end
  #     team_id_swap(worst)
  #   elsif where == "home" && most_least == "least"
  #     hash = average_home_goals_per_team
  #     lowest_avg = 50
  #     worst = nil
  #     hash.each do |team,average|
  #       if average < lowest_avg
  #         lowest_avg = average
  #         worst = team
  #       end
  #     end
  #     team_id_swap(worst)
  #   else
  #     hash = average_home_goals_per_team
  #     highest_avg = 0
  #     best = nil
  #     hash.each do |team,average|
  #       if average > highest_avg
  #         highest_avg = average
  #         best = team
  #       end
  #     end
  #     team_id_swap(best)
  #   end
  # end
end
