module List

  def all_games_for_team(team)
    hash_home_games_by_team[team] + hash_away_games_by_team[team]
  end


  def team_id_swap(input)
    desired_team = @teams.repo.find do |team|
      team.team_id == input
    end
    desired_team.team_name
  end


  # def get_all_opponents_game_team_data(team) #bananas
  #   game_ids = hash_game_teams_by_team[team].map do |game_team|
  #     game_team.game_id
  #   end
  #   opponents = hash_game_teams_by_team.reject do |team_id, game_teams|
  #     team_id == team
  #   end
  #   game_teams = opponents.values
  #   game_teams.flatten!
  #   x = game_teams.find_all do |game_team|
  #     game_ids.include?(game_team.game_id)
  #   end
  # end


  def total_points_for_team(team) #bananas
    game_teams = hash_game_teams_by_team[team]
    game_teams.inject(0) do |sum, game_team|
      sum + game_team.goals
    end
  end

  # def total_points_against(team)
  #   team_id_swap(team)
  #   game_teams = get_all_opponents_game_team_data(team)
  #   total = 0
  #   game_teams.each do |game_team|
  #     total += game_team.goals
  #   end
  #   total.to_f
  # end


  def won_games(team) #bananas
    won_home = won_home_games(team)
    won_away = won_away_games(team)
    won_games = won_home + won_away
  end



  def win_percentage(team) #bananas
    game_teams = hash_game_teams_by_team[team]
    won_game_teams = game_teams.find_all do |game_team|
      game_team.won? == true
    end
    (won_game_teams.count.to_f / game_teams.count).round(2)
  end

  def total_scores
    @games.repo.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def teams_score_difference
    @games.repo.map do |game|
      (game.away_goals - game.home_goals)
    end
  end

  def total_games
    @games.repo.map do |game|
      game.game_id
    end.size
  end

  def total_visitor_wins
    teams_score_difference.select do |score_diff|
      score_diff > 0
    end.size
  end

  def total_goals_all_seasons
    total_away_goals = @games.repo.sum do |game|
      game.away_goals
    end
    total_home_goals = @games.repo.sum do |game|
      game.home_goals
    end
    total_away_goals + total_home_goals
  end


end
