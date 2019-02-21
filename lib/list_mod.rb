module List

  def all_games_for_team(team) #bananas
    hash_home_games_by_team[team] + hash_away_games_by_team[team]
  end


  def team_id_swap(input) #bananas
    desired_team = @teams.repo.find do |team|
      team.team_id == input
    end
    desired_team.team_name
  end


  def get_all_opponents_game_team_data(team) #bananas
    game_ids = hash_game_teams_by_team[team].map do |game_team|
      game_team.game_id
    end
    opponents = hash_game_teams_by_team.reject do |team_id, game_teams|
      team_id == team
    end
    game_teams = opponents.values
    game_teams.flatten!
    game_teams.find_all do |game_team|
      game_ids.include?(game_team.game_id)
    end
  end


  def total_points_for_team(team) #bananas
    game_teams = hash_game_teams_by_team[team]
    game_teams.inject(0) do |sum, game_team|
      sum + game_team.goals
    end
  end

  # def total_points_against(team,season)
  #   home_games = hash_home_games_by_team[team].find_all do |game|
  #     game.game_id[0...4] == season[0...4]
  #   end
  #   away_games = hash_away_games_by_team[team].find_all do |game|
  #     game.game_id[0...4] == season[0...4]
  #   end
  #
  #   away_points = home_games.sum do |game|
  #     game.away_goals
  #   end
  #   home_points = away_games.sum do |game|
  #     game.home_goals
  #   end
  #   away_points + home_points
  # end


  def won_games(team) #bananas
    won_home = won_home_games(team)
    won_away = won_away_games(team)
    won_home + won_away
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

  def all_wins_vs_opponent(team_id) #helper
     game_ids = won_games(team_id)

     all_teams = []
     game_ids.each do |game|
       all_teams << game.away_team_id << game.home_team_id
     end

     count_by_team_id = {}
     opponents = all_teams.reject { |team| team == team_id }
     opponents.each do |team|
       count_by_team_id[team] = opponents.count(team).to_f
     end
     count_by_team_id
  end

  def all_games_vs_opponent(team_id) #helper
    game_ids = all_games_for_team(team_id)

    all_teams = []
    game_ids.each do |game|
      all_teams << game.away_team_id << game.home_team_id
    end

    count_by_team_id = {}
    opponents = all_teams.reject { |team| team == team_id }
    opponents.each do |team|
      count_by_team_id[team] = opponents.count(team).to_f
    end
    count_by_team_id
  end

  def all_opponents_game_teams(team_id) #helper
    hash = all_games_played(team_id).group_by do |game_team|
      game_team.team_id
    end
    hash
  end

  def win_game_ids(team_id) #helper
    all_wins_by_team(team_id).map do |win| #repeats
      win.game_id
    end
  end

  def loss_game_ids(team_id) #helper
    all_losses_by_team(team_id).map do |loss| #repeats
      loss.game_id
    end
  end


  def all_wins_by_team(team_id) #helper
    all_games_played(team_id).find_all do |game_team|
      game_team.won?
    end
  end

  def all_losses_by_team(team_id) #helper
    all_games_played(team_id).find_all do |game_team|
      game_team.won? == false
    end
  end

  def max_goal_differential_from_games(game_ids) #helper
    game_goals = @games.repo.find_all do |game|
      game_ids.include?(game.game_id)
    end
    max_goal_differential(game_goals)
  end

  def max_goal_differential(game_goals) #helper
    differential = []
    game_goals.each do |game|
      differential << (game.away_goals - game.home_goals).abs
    end
    differential.max
  end

  def all_goals(team_id) #helper
    all_games_played(team_id).map do |game|
      game.goals
    end
  end

  def game_team_games_by_year(team_id) #helper
    all_games_played(team_id).group_by do |game_team|
      game_id_to_season(game_team.game_id)
    end
  end

  def game_count_per_year(team_id) #helper
    games_per_year = {}
    game_team_games_by_year(team_id).each do |season, game_teams|
      games_per_year[season] = game_teams.count
    end
    games_per_year
    end


  def game_team_wins_by_year(team_id) #helper
    all_wins_by_team(team_id).group_by do |game_team|
      game_id_to_season(game_team.game_id) #game_id_to_year method
    end
  end

  def win_count_per_year(team_id) #helper
    wins_per_year = {}
    game_team_wins_by_year(team_id).each do |season, game_teams|
      wins_per_year[season] = game_teams.count
    end
    wins_per_year
  end

  def win_percentage_by_season(team_id) #helper
    season_win_percentage = {}
    all_seasons(team_id).each do |season|
      season_win_percentage[season] =
      ((win_count_per_year(team_id)[season].to_f / game_count_per_year(team_id)[season]))
    end
    season_win_percentage
  end


  def all_games_played(team_id) #helper
    hash_game_teams_by_team[team_id]
  end

  def all_game_ids_by_team(team_id) #helper
    all_game_ids = []
    all_games_played(team_id).find_all do |game_team|
      all_game_ids << game_team.game_id
    end
    all_game_ids
  end

  def all_seasons(team_id) #helper
    years = all_game_ids_by_team(team_id).map do |game_id|
      game_id_to_season(game_id)
    end
    years.uniq!
    years.sort
  end



  def team_win_pct_by_season(team_id,game_array)
    all_home = game_array & hash_home_games_by_team[team_id]
    won_home = all_home.find_all do |game|
      game.outcome.include?("home")
    end
    all_away = game_array & hash_away_games_by_team[team_id]
    won_away = all_away.find_all do |game|
      game.outcome.include?("away")
    end
    (won_home.count + won_away.count).to_f / (all_home.count + all_away.count)
  end

  def team_scored_by_season(team_id,game_array)
    all_home = game_array & hash_home_games_by_team[team_id]
    home_pts = all_home.sum do |game|
      game.home_goals
    end
    all_away = game_array & hash_away_games_by_team[team_id]
    away_pts = all_away.sum do |game|
      game.away_goals
    end
    home_pts + away_pts
  end

  def team_opp_scored_by_season(team_id,game_array)
    all_home = game_array & hash_home_games_by_team[team_id]
    home_pts = all_home.sum do |game|
      game.away_goals
    end
    all_away = game_array & hash_away_games_by_team[team_id]
    away_pts = all_away.sum do |game|
      game.home_goals
    end
    home_pts + away_pts
  end

end
