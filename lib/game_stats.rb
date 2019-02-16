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

  def total_score(game_id)
    
  end

  def biggest_blowout
    #max_buy(each game(@home_score - @away_score)) abs diff
    #integer
  end

  # def percentage_home_wins
    
  # end

  # def percentage_visitor_wins
  #   #(100 - percentage_home_wins)
  #   #float, round(2)
  # end


  def total_games
    @games.repo.map do |game|
      game.game_id
    end.length
  end 

  # def total_home_wins
    
    
  # end 

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