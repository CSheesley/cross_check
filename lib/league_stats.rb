module LeagueStats

  def count_of_teams
    list = array_of_teams
    list.count
    # @teams.repo.count
  end


  def best_offense
    list = array_of_teams
    team = list.max_by do |team_name| #for each team_name in hash
      highest_avg = 0
      total_points = total_points_for_team(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  end

  def worst_offense
    list = array_of_teams
    team = list.min_by do |team_name|
      highest_avg = 0
      total_points = total_points_for_team(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  end

  def best_defense
    list = array_of_teams
    team = list.min_by do |team_name|
      lowest_avg = nil
      total_points = total_points_against(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        lowest_avg = total_points / total_games
      end
      lowest_avg
    end
    team
  end

  def worst_defense
    list = array_of_teams
    team = list.max_by do |team_name|
      highest_avg = nil
      total_points = total_points_against(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  end

  def highest_scoring_visitor
    list = array_of_teams
    team = list.max_by do |team_name|
      total_away_goals = 0
      aways = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "home"
      end
      aways.each do |game|
        total_away_goals += game.goals
      end
      total_away_goals
    end
    team
  end

  def lowest_scoring_visitor
    list = array_of_teams
    team = list.min_by do |team_name|
      total_away_goals = 0
      aways = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "home"
      end
      aways.each do |game|
        total_away_goals += game.goals
      end
      total_away_goals
    end
    team
  end

  def highest_scoring_home_team
    list = array_of_teams
    team = list.max_by do |team_name|
      total_home_goals = 0
      homes = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "away"
      end
      homes.each do |game|
        total_home_goals += game.goals
      end
      total_home_goals
    end
  end

  def lowest_scoring_home_team
    list = array_of_teams
    team = list.min_by do |team_name|
      total_home_goals = 0
      homes = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "away"
      end
      homes.each do |game|
        total_home_goals += game.goals
      end
      total_home_goals
    end
  end


  def winningest_team
    list = array_of_teams
    list.max_by do |team_name|
      win_percentage(team_name)
    end
  end

  def best_fans
    list = array_of_teams
    best = list.max_by do |team|
        home_wins = get_team_home_games(team) & won_games(team)
      away_wins = get_team_away_games(team) & won_games(team)
      home_wins.count - away_wins.count
    end
  end

  def worst_fans
    list = array_of_teams
    worst = list.find_all do |team|
      home_wins = (get_team_home_games(team) & won_games(team)).count.to_f * 100 / get_team_home_games(team).count
      away_wins = (get_team_home_games(team) & won_games(team)).count.to_f * 100 / get_team_home_games(team).count
      home_wins < away_wins
    end
  end
end
