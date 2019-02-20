module LeagueStats
  # take 11.15 sec (mostly best/worst defense)
  def count_of_teams
    @teams.repo.count
  end


  def best_offense #bananas
    teams = hash_game_teams_by_team.keys
    best = teams.max_by do |team|
      highest_avg = 0
      total_points = total_points_for_team(team)
      total_games = hash_game_teams_by_team[team].count
      if total_games > 0
        highest_avg = total_points.to_f / total_games
      end
      highest_avg
    end
    team_id_swap(best)
  end

  def worst_offense #bananas
    teams = hash_game_teams_by_team.keys
    worst = teams.min_by do |team|
      lowest_avg = 0
      total_points = total_points_for_team(team)
      total_games = hash_game_teams_by_team[team].count
      if total_games > 0
        lowest_avg = total_points.to_f / total_games
      end
      lowest_avg
    end
    team_id_swap(worst)
  end

  def best_defense #bananas # takes 6.35 sec
    teams = hash_game_teams_by_team.keys
    best = nil
    lowest = 100
    teams.each do |team|
      game_teams = get_all_opponents_game_team_data(team)
      total_points = game_teams.inject(0) do |sum, game_team|
        sum + game_team.goals
      end
      total_games = game_teams.count
      if (total_points.to_f / total_games).round(2) < lowest
        lowest = (total_points.to_f / total_games).round(2)
        best = team
      end
    end
    team_id_swap(best)
  end

  def worst_defense #bananas takes 5.31 sec
    teams = hash_game_teams_by_team.keys
    worst = nil
    highest = 0
    teams.each do |team|
      game_teams = get_all_opponents_game_team_data(team)
      total_points = game_teams.inject(0) do |sum, game_team|
        sum + game_team.goals
      end
      total_games = game_teams.count
      if (total_points.to_f / total_games).round(2) > highest
        highest = (total_points.to_f / total_games).round(2)
        worst = team
      end
    end
    team_id_swap(worst)
  end

  def average_away_goals_per_team #bananas helper
    avg_hash = {}
    hash_away_games_by_team.each do |team,games|
      sum = games.sum { |game| game.away_goals}
      avg_hash[team] = (sum.to_f / games.count)
    end
    avg_hash
  end

  def average_home_goals_per_team #bananas helper
    avg_hash = {}
    hash_home_games_by_team.each do |team,games|
      sum = games.sum { |game| game.home_goals}
      avg_hash[team] = (sum.to_f / games.count)
    end
    avg_hash
  end

  def average_goals(where,most_least) #bananas helper
    if where == "away" && most_least == "most"
      hash = average_away_goals_per_team
      highest_avg = 0
      best = nil
      hash.each do |team,average|
        if average > highest_avg
          highest_avg = average
          best = team
        end
      end
      team_id_swap(best)
    elsif where == "away" && most_least == "least"
      hash = average_away_goals_per_team
      lowest_avg = 50
      worst = nil
      hash.each do |team,average|
        if average < lowest_avg
          lowest_avg = average
          worst = team
        end
      end
      team_id_swap(worst)
    elsif where == "home" && most_least == "least"
      hash = average_home_goals_per_team
      lowest_avg = 50
      worst = nil
      hash.each do |team,average|
        if average < lowest_avg
          lowest_avg = average
          worst = team
        end
      end
      team_id_swap(worst)
    else
      hash = average_home_goals_per_team
      highest_avg = 0
      best = nil
      hash.each do |team,average|
        if average > highest_avg
          highest_avg = average
          best = team
        end
      end
      team_id_swap(best)
    end
  end

  def highest_scoring_visitor #bananas
    average_goals("away","most")
  end

  def lowest_scoring_visitor #bananas
        average_goals("away","least")
  end

  def highest_scoring_home_team #bananas
        average_goals("home","most")
  end

  def lowest_scoring_home_team #bananas
    average_goals("home","least")
  end


  def winningest_team #bananas
    teams = hash_game_teams_by_team.keys
    best = teams.max_by do |team|
      win_percentage(team)
    end
    team_id_swap(best)

  end

  def won_home_games(team) #bananas helper
    hash_home_games_by_team[team].find_all do |game|
      game.outcome.include?("home")
    end
  end

  def won_away_games(team) #bananas helper
    hash_away_games_by_team[team].find_all do |game|
      game.outcome.include?("away")
    end
  end

  def best_fans #bananas
    teams = hash_game_teams_by_team.keys
    best = teams.max_by do |team|
      home = (won_home_games(team).count.to_f/hash_home_games_by_team[team].count)
      away = (won_away_games(team).count.to_f/hash_away_games_by_team[team].count)
      home - away
    end
    team_id_swap(best)
  end

  def worst_fans #bananas
    teams = hash_game_teams_by_team.keys
    worst = teams.find_all do |team|
      home = (won_home_games(team).count.to_f/hash_home_games_by_team[team].count)
      away = (won_away_games(team).count.to_f/hash_away_games_by_team[team].count)
      away - home > 0
    end
    worst.map do |team|
      team_id_swap(team)
    end
  end
end
