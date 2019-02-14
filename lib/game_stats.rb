module GameStats
  def highest_total_score
    @games.max_by |
    #max_by(each game(@home_score + @away_score))
    #total goals per game
    #module or instance method: total_score = sum(home + away)
    #@games.map {|game| sum(h + a)}
    #integer
    #remove duplicates 
  end

  def lowest_total_score
    #min_by(each game(@home_score + @away_score))
    #integer
  end

  def total_score(game_id)

  end 

  def biggest_blowout
    #max_buy(each game(@home_score - @away_score)) abs diff 
    #integer
  end

  def absolute_diff? #may not need 
  end 

  def percentage_home_wins
    #total_home_wins = games where home_goals > away_goals
    #total_home_wins/total_games
    #float, round(2)
  end

  def total_games
    @games.map.sum 
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

class StatTracker
  attr_accessor :games, :game_teams, :teams

  def self.from_csv(locations)
    st            = StatTracker.new
    st.games      = GameRepo.new(locations[:games], self)
    st.game_teams = GameTeamRepo.new(locations[:game_teams], self)
    st.teams      = TeamRepo.new(locations[:teams], self)
    st
  end
end