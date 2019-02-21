module Summary
  def win_game_ids(team_id)
    all_wins_by_team(team_id).map do |win|
      win.game_id
    end
  end

  def loss_game_ids(team_id)
    all_losses_by_team(team_id).map do |loss|
      loss.game_id
    end
  end

  def all_wins_by_team(team_id)
    all_games_played(team_id).find_all do |game_team|
      game_team.won?
    end
  end

  def all_losses_by_team(team_id)
    all_games_played(team_id).find_all do |game_team|
      game_team.won? == false
    end
  end

  def max_goal_differential_from_games(game_ids)
    game_goals = @games.repo.find_all do |game|
      game_ids.include?(game.game_id)
    end
    max_goal_differential(game_goals)
  end

  def max_goal_differential(game_goals)
    differential = []
    game_goals.each do |game|
      differential << (game.away_goals - game.home_goals).abs
    end
    differential.max
  end

  def all_goals(team_id)
    all_games_played(team_id).map do |game|
      game.goals
    end
  end

  def game_team_games_by_year(team_id)
    all_games_played(team_id).group_by do |game_team|
      game_id_to_season(game_team.game_id)
    end
  end

  def game_count_per_year(team_id)
    games_per_year = {}
    game_team_games_by_year(team_id).each do |season, game_teams|
      games_per_year[season] = game_teams.count
    end
    games_per_year
  end

  def game_team_wins_by_year(team_id)
    all_wins_by_team(team_id).group_by do |game_team|
      game_id_to_season(game_team.game_id)
    end
  end

  def win_count_per_year(team_id)
    wins_per_year = {}
    game_team_wins_by_year(team_id).each do |season, game_teams|
      wins_per_year[season] = game_teams.count
    end
    wins_per_year
  end

  def win_percentage_by_season(team_id)
    season_win_percentage = {}
    all_seasons(team_id).each do |season|
      season_win_percentage[season] =
      ((win_count_per_year(team_id)[season].to_f / game_count_per_year(team_id)[season]))
    end
    season_win_percentage
  end

  def all_games_played(team_id)
    hash_game_teams_by_team[team_id]
  end

  def all_game_ids_by_team(team_id)
    all_game_ids = []
    all_games_played(team_id).find_all do |game_team|
      all_game_ids << game_team.game_id
    end
    all_game_ids
  end

  def all_seasons(team_id)
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
