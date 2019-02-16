require 'pry'

module GameStats
  def highest_total_score
    total_scores.max 
  end

  def lowest_total_score
    total_scores.min
  end

  def total_scores
    @games.repo.map do |game|
      game.away_goals + game.home_goals
    end 
  end 

  def biggest_blowout
    teams_score_difference.max.abs
  end

  def teams_score_difference
    @games.repo.map do |game|
      (game.away_goals - game.home_goals)
    end 
  end 

  def percentage_home_wins
    (1 - percentage_visitor_wins.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_visitor_wins/total_games.to_f).round(2)
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

  def count_of_games_by_season(season) #to go module?
    games_for_season = @games.repo.select do |game|
      game.season == season
    end
    season_games_count = {}
    season_games_count[season] = games_for_season.size
    season_games_count
  end

  def average_goals_per_game
    #(total_goals_all_seasons)/total_games_all_seasons
    #float, round(2)
  end

  def total_goals_all_seasons
    #(all home team goals + all away team goals) / total games
  end

  def average_goals_by_season(season)
    #season.total_goals/season.total_games
    #hash with season_names as keys and a float.round(2) representing average number of goals in a game for that season as a value (spec says key? double check with Amy/Brian)
  end
end 