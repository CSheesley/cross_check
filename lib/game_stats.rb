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

  def count_of_games_by_season
    games_by_season = @games.repo.group_by do |game|
      game.season
    end
    games_by_season.each do |season, games|
      games_by_season[season] = games.count
    end
    games_by_season
  end

  # def games_by_season
  #   @games.repo.group_by do |game|
  #     game.season
  #   end
  # end

  def average_goals_per_game
    (total_goals_all_seasons/total_games.to_f).round(2)
  end

  def total_goals_all_seasons
    total_away_goals = @games.repo.sum do |game|
      game.away_goals
    end
    total_home_goals = @games.repo.sum do |game|
      game.home_goals
    end
    total_away_goals + total_home_goals
  end

  def average_goals_by_season
    average_goals_by_season = {}
    games_by_season = @games.repo.group_by do |game|
      game.season
    end
    games_by_season.each do |season, games|
      goals = games.sum do |game|
        (game.away_goals + game.home_goals)
      end
      average_goals_by_season[season] = (goals.to_f/games.count).round(2)
    end
    average_goals_by_season
  end
end
