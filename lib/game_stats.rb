module GameStats
  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def biggest_blowout
    teams_score_difference.max.abs
  end

  def percentage_home_wins
    (1 - percentage_visitor_wins.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_visitor_wins/total_games.to_f).round(2)
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    hash_games_by_season.each do |season, games| 
      count_of_games_by_season[season] = games.count 
    end 
    count_of_games_by_season
  end

  def average_goals_per_game
    (total_goals_all_seasons/total_games.to_f).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = {}
    hash_games_by_season.each do |season, games|
      goals = games.sum do |game|
        (game.away_goals + game.home_goals)
      end
      average_goals_by_season[season] = (goals.to_f/games.count).round(2)
    end
    average_goals_by_season
  end
end
