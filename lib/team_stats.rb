module TeamStats

  def team_info(team_id)
    get_team_info(team_id)
    {
      "team_id" => get_team_info(team_id).team_id,
      "franchise_id" => get_team_info(team_id).franchise_id,
      "short_name" => get_team_info(team_id).short_name,
      "team_name" => get_team_info(team_id).team_name,
      "abbreviation" => get_team_info(team_id).abbreviation,
      "link" => get_team_info(team_id).link
    }
  end

  def get_team_info(team_id) #helper
    @teams.repo.find do |team|
      team.team_id == team_id
    end
  end

  def best_season(team_id)
    seasons = win_percentage_by_season(team_id).to_a
    seasons.max_by do |year_percent|
      year_percent[1]
    end.first
  end

  def worst_season(team_id)
    seasons = win_percentage_by_season(team_id).to_a
    seasons.min_by do |year_percent|
      year_percent[1]
    end.first
  end

  def average_win_percentage(team_id)
    total_wins = all_wins_by_team(team_id).count
    total_games = all_games_played(team_id).count
    (total_wins.to_f / total_games).round(2)
  end

  def most_goals_scored(team_id)
    all_goals(team_id).max
  end

  def fewest_goals_scored(team_id)
    all_goals(team_id).min
  end

  def favorite_opponent(team_id)
    favorite = head_to_head(team_id).max_by {|team, percentage| percentage}
    favorite.first
  end

  def rival(team_id)
    rival = head_to_head(team_id).min_by {|team, percentage| percentage}
    rival.first
  end

  def biggest_team_blowout(team_id)
    game_ids = win_game_ids(team_id)
    max_goal_differential_from_games(game_ids)
  end

  def worst_loss(team_id)
    game_ids = loss_game_ids(team_id)
    max_goal_differential_from_games(game_ids)
  end

  def head_to_head(team_id)
    win_percentage_by_team = {}
    all_wins_vs_opponent(team_id).each do |team, wins|
      win_percentage_by_team[team_id_swap(team)] = ((wins / all_games_vs_opponent(team_id)[team]).round(2))
    end
    win_percentage_by_team
  end

  def seasonal_summary_p(team_id,season)
    all_games = hash_games_by_season[season] & all_games_for_team(team_id)
    pre = all_games.find_all do |game|
      game.type == "P"
    end
    hash = {}
    if pre.count > 0
      hash[:win_percentage] = team_win_pct_by_season(team_id,pre).round(2)
      hash[:total_goals_scored] = team_scored_by_season(team_id,pre)
      hash[:total_goals_against] = team_opp_scored_by_season(team_id,pre)
      hash[:average_goals_scored] = (team_scored_by_season(team_id,pre).to_f / pre.count).round(2)
      hash[:average_goals_against] = (team_opp_scored_by_season(team_id,pre).to_f / pre.count).round(2)
    else
      hash[:win_percentage] = 0
      hash[:total_goals_scored] = 0
      hash[:total_goals_against] = 0
      hash[:average_goals_scored] = 0.0
      hash[:average_goals_against] = 0.0
    end
    hash
  end

  def seasonal_summary_r(team_id,season)
    all_games = hash_games_by_season[season] & all_games_for_team(team_id)
    reg = all_games.find_all do |game|
      game.type == "R"
    end
    hash = {}
    if reg.count > 0
      hash[:win_percentage] = team_win_pct_by_season(team_id,reg).round(2)
      hash[:total_goals_scored] = team_scored_by_season(team_id,reg)
      hash[:total_goals_against] = team_opp_scored_by_season(team_id,reg)
      hash[:average_goals_scored] = (team_scored_by_season(team_id,reg).to_f / reg.count).round(2)
      hash[:average_goals_against] = (team_opp_scored_by_season(team_id,reg).to_f / reg.count).round(2)
    end
    hash
  end


  def seasonal_summary(team_id)
    summary_hash ={}

    seasons = all_seasons(team_id)
    seasons.each do |season|
      season_info = {preseason: {},
                      regular_season: {}}
      season_info[:preseason] = seasonal_summary_p(team_id,season)
      season_info[:regular_season] = seasonal_summary_r(team_id,season)
      summary_hash[season] = season_info
    end
    summary_hash
  end

end
