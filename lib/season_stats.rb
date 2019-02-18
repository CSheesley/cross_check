module SeasonStats

  def biggest_bust(season)
    list = find_games_by_season(season)
    teams = []
    list.each do |game|
      teams << game.away_team_id
      teams << game.home_team_id
    end
    teams.uniq!
    bust = teams.min_by do |team|
      reg = (won_games(team) & regular_games(team)).count / regular_games(team).count.to_f * 100
      pre = (won_games(team) & preseason_games(team)).count / preseason_games(team).count.to_f * 100
      reg - pre
    end
    team_id_swap(bust)
  end


  def biggest_suprise(season)
    list = find_games_by_season(season)
    teams = []
    list.each do |game|
      teams << game.away_team_id
      teams << game.home_team_id
    end
    teams.uniq!
    surprise = teams.max_by do |team|
      reg = (won_games(team) & regular_games(team)).count / regular_games(team).count.to_f * 100
      pre = (won_games(team) & preseason_games(team)).count / preseason_games(team).count.to_f * 100
      reg - pre
    end
    team_id_swap(surprise)
  end


  def winningest_coach(season)
    list = find_game_teams_by_season(season)
    best = list.max_by do |game_team|
      won_games(game_team.team_id).count
      # binding.pry
    end
    best.head_coach
  end


  def worst_coach(season)
    list = find_game_teams_by_season(season)
    worst = list.min_by do |game_team|
      won_games(game_team.team_id).count
    end
    worst.head_coach
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
