module HashModule
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
end
