module SeasonStats
  #takes 2.62 seconds
  def teams_in_season(season) #bananas
    season = hash_games_by_season[season]
    teams = []
    season.each do |game|
      teams << game.away_team_id
      teams << game.home_team_id
    end
    teams.uniq!
  end

  def create_reg_pre_hash(game_hash,team)
    hash = Hash.new {|hash,key| hash[key] = 0}
    reg_games = all_games_for_team(team) & game_hash["R"]
    pre_games = all_games_for_team(team) & game_hash["P"]
    total_reg = reg_games.count
    total_pre = pre_games.count
    won_reg = (game_hash["R"] & won_games(team)).count.to_f
    won_pre = (game_hash["P"] & won_games(team)).count.to_f
    if total_pre > 0
      hash[:reg_win_pct] = won_reg / total_reg
      hash[:pre_win_pct] = won_pre / total_pre
    end
    hash
  end

  def reg_pre_diff_hash(season) #bananas helper
    reg_v_pre = hash_games_by_season[season].group_by do |game|
      game.type
    end
    teams = teams_in_season(season)
    hash = {}
    teams.each do |team|
      hash[team] = create_reg_pre_hash(reg_v_pre,team)
    end
    hash
  end

  def biggest_bust(season) #bananas
    diff_hash = reg_pre_diff_hash(season)
    h = {}
    diff_hash.each do |team,pcts|
      h[team] = pcts[:reg_win_pct] - pcts[:pre_win_pct]
    end
    surprise = h.key(h.values.min)
    team_id_swap(surprise)
  end


  def biggest_surprise(season) #bananas
    diff_hash = reg_pre_diff_hash(season)
    h = {}
    diff_hash.each do |team,pcts|
      h[team] = pcts[:reg_win_pct] - pcts[:pre_win_pct]
    end
    surprise = h.key(h.values.max)
    team_id_swap(surprise)
  end



  def season_winningest_hash(season) #bananas helper
    teams = teams_in_season(season)
    games = hash_games_by_season[season]
    pct_hash = {}
    teams.each do |team|
      total = (games.find_all {|game| game.away_team_id == team || game.home_team_id == team}).count
      won = (games & won_games(team)).count.to_f
      pct_hash[team] = won / total
    end
    pct_hash
  end



  def winningest_coach(season) #bananas
    hash = all_game_teams_for_season(season)
    by_coach = hash.values.flatten!.group_by do |game_team|
      game_team.head_coach
    end
    pct_hash = {}
    by_coach.each do |coach,game_teams|
      won = (game_teams.find_all do |game_team|
        game_team.won? == true
      end)
      pct_hash[coach] = won.count.to_f / game_teams.count
    end
    pct_hash.key(pct_hash.values.max)
  end


  def worst_coach(season) #bananas
    hash = all_game_teams_for_season(season)
    by_coach = hash.values.flatten!.group_by do |game_team|
      game_team.head_coach
    end
    pct_hash = {}
    by_coach.each do |coach,game_teams|
      won = (game_teams.find_all do |game_team|
        game_team.won? == true
      end)
      pct_hash[coach] = won.count.to_f / game_teams.count
    end
    pct_hash.key(pct_hash.values.min)
  end


  def most_accurate_team(season) #bananas
    find_most_or_least_for_season(season, "accuracy", "most")
  end


  def least_accurate_team(season) #bananas
    find_most_or_least_for_season(season, "accuracy", "least")
  end


  def most_hits(season) #bananas
    find_most_or_least_for_season(season, "hits", "most")
  end


  def least_hits(season) #bananas
    find_most_or_least_for_season(season,"hits","least")
  end


  def power_play_goal_percentage(season)
    game_teams = (all_game_teams_for_season(season).values).flatten
    pp_goals = game_teams.reduce(0) do |sum, game_team|
      sum += game_team.power_play_goals
    end
    pp_goals = pp_goals.to_f
    total_goals = game_teams.reduce(0) do |sum, game_team|
      sum += (game_team.goals)
    end
    (pp_goals / total_goals).round(2)
  end




  def game_id_to_season(game_id) #helper
    game_team = @games.repo.find do |game|
      game.game_id == game_id
    end
    game_team.season
  end

  def all_game_teams_for_season(season) #bananas helper
    hash = @game_teams.repo.group_by do |game_team|
      game_team.game_id[0...4]
    end
    hash.keep_if do |game_id,game_teams|
      game_id[0...4] == season[0...4]
    end
  end
end
