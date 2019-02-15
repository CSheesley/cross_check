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
    absolute_diff_teams_score.max
  end

  def absolute_diff_teams_score
    diff = @games.repo.map do |game|
      (game.away_goals - game.home_goals).abs
    end
  end 

  def percentage_home_wins
    #total_home_wins = games where home_goals > away_goals
    #total_home_wins/total_games
    #float, round(2)
  end

  def total_games
    #@games.map.sum 
  end 

  def percentage_visitor_wins
    #(100 - percentage_home_wins)
    #float, round(2)
  end

  def count_of_games_by_season(season) #to go module?
    #seaon_names_array
    #use collect?
    #hash of season_names (20122013) as keys, #count_of_games as values
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