module Season
  def teams_in_season(season)
    season = hash_games_by_season[season]
    teams = []
    season.each do |game|
      teams << game.away_team_id
      teams << game.home_team_id
    end
    teams.uniq!
  end

  def create_reg_pre_hash(game_hash,team)
    h = Hash.new {|hash,key| hash[key] = 0}
    reg_games = all_games_for_team(team) & game_hash["R"]
    pre_games = all_games_for_team(team) & game_hash["P"]
    total_reg = reg_games.count
    total_pre = pre_games.count
    won_reg = (game_hash["R"] & won_games(team)).count.to_f
    won_pre = (game_hash["P"] & won_games(team)).count.to_f
    if total_pre > 0
      h[:reg_win_pct] = won_reg / total_reg
      h[:pre_win_pct] = won_pre / total_pre
    end
    h
  end

  def reg_pre_diff_hash(season)
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

  def game_id_to_season(game_id)
    game_team = @games.repo.find do |game|
      game.game_id == game_id
    end
    game_team.season
  end

  def all_game_teams_for_season(season)
    hash = @game_teams.repo.group_by do |game_team|
      game_team.game_id[0...4]
    end
    hash.keep_if do |game_id,game_teams|
      game_id[0...4] == season[0...4]
    end
  end
end
