module SeasonStats
  def biggest_bust(season)
    diff_hash = reg_pre_diff_hash(season)
    h = {}
    diff_hash.each do |team,pcts|
      h[team] = pcts[:reg_win_pct] - pcts[:pre_win_pct]
    end
    surprise = h.key(h.values.min)
    team_id_swap(surprise)
  end

  def biggest_surprise(season)
    diff_hash = reg_pre_diff_hash(season)
    h = {}
    diff_hash.each do |team,pcts|
      h[team] = pcts[:reg_win_pct] - pcts[:pre_win_pct]
    end
    surprise = h.key(h.values.max)
    team_id_swap(surprise)
  end

  def winningest_coach(season)
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

  def worst_coach(season)
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

  def most_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "most")
  end

  def least_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "least")
  end

  def most_hits(season)
    find_most_or_least_for_season(season, "hits", "most")
  end

  def least_hits(season)
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
end
