module SeasonStats
  def teams_in_season(season) #bananas
    season = hash_games_by_season[season]
    teams = []
    season.each do |game|
      teams << game.away_team_id
      teams << game.home_team_id
    end
    teams.uniq!
  end

  def reg_pre_diff_hash(season) #bananas helper
    teams = teams_in_season(season)
    reg_v_pre = hash_games_by_season[season].group_by do |game|
      game.type
    end
    total_reg_games = {}
    teams.each do |team|
      total_reg_games[team] = (reg_v_pre["R"] & all_games_for_team(team)).count.to_f
    end
    total_pre_games = {}
    teams.each do |team|
      total_pre_games[team] = (reg_v_pre["P"] & all_games_for_team(team)).count.to_f
    end
    reg_hash = {}
    teams.each do |team|
      reg_hash[team] = (reg_v_pre["R"] & won_games(team)).count
    end
    pre_hash = {}
    teams.each do |team|
      pre_hash[team] = (reg_v_pre["P"] & won_games(team)).count
    end
    diff_hash = {}
    teams.each do |team|
      diff_hash[team] = (pre_hash[team]/total_pre_games[team] - reg_hash[team]/total_reg_games[team])
    end
    diff_hash.delete_if do |team,diff|
      diff.nan?
    end
  end

  def biggest_bust(season) #bananas
    diff_hash = reg_pre_diff_hash(season)
    bust = diff_hash.key(diff_hash.values.max)
    team_id_swap(bust)
  end


  def biggest_surprise(season) #bananas
    diff_hash = reg_pre_diff_hash(season)
    surprise = diff_hash.key(diff_hash.values.min)
    team_id_swap(surprise)
  end



  def season_winningest_hash(season)
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

  def all_game_teams_for_season(season) #bananas helper
    hash = @game_teams.repo.group_by do |game_team|
      game_team.game_id[0...4]
    end
    hash.keep_if do |game_id,game_teams|
      game_id[0...4] == season[0...4]
    end
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



  def most_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "most")
  end


  def least_accurate_team(season)
    find_most_or_least_for_season(season, "accuracy", "least")
  end


  def most_hits(season)
    find_most_or_least_for_season(season, "hits", "most")
  end



  def find_most_or_least_for_season(season, attribute, most_or_least)
    list = find_game_teams_by_season(season)
    team = nil
    most = 0
    sum = 0
    least = 5000 #what should I put here
    if most_or_least == "most"
      if attribute == "hits"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          sum = games.sum do |game|
            game.hits
          end
          if sum > most
            most = sum
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      elsif attribute == "accuracy"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          shots = games.sum do |game|
            game.shots
          end
          goals = games.sum do |game|
            game.goals
          end
          ratio = goals / shots.to_f
          if ratio > most
            most = ratio
            team = game_team.team_id
          end
          # binding.pry
        end
        team_id_swap(team)
      end
    else
      if attribute == "hits"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          sum = games.sum do |game|
            game.hits
          end
          if sum < least
            least = sum
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      elsif attribute == "accuracy"
        list.each do |game_team|
          games = get_all_game_teams_for_team(game_team.team_id)
          shots = games.sum do |game|
            game.shots
          end
          goals = games.sum do |game|
            game.goals
          end
          ratio = goals / shots.to_f
          if ratio < least
            least = ratio
            team = game_team.team_id
          end
        end
        team_id_swap(team)
      end
    end
  end


  def least_hits(season)
    find_most_or_least_for_season(season,"hits","least")
  end



  def game_id_to_season(game_id)
    game_team = @games.repo.find do |game|
      game.game_id == game_id
    end
    game_team.season
  end



  def power_play_goal_percentage(season)
    list = find_game_teams_by_season(season)
    pp_goals = list.reduce(0) do |sum, game_team|
      sum += game_team.power_play_goals
    end
    pp_goals = pp_goals.to_f
    total_goals = list.reduce(0) do |sum, game_team|
      sum += (game_team.goals)
    end
    (100 * pp_goals / total_goals).round(2)
  end

end
