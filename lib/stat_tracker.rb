
class StatTracker
  def initialize
  end


  def self.from_csv(locations)
    locations.each do |location|
      # puts location.last
    end
    StatTracker.new
  end
end



# def test_stat_tracker_makes_game_repo_when_initialized
#   assert_instance_of GameRepo, @stat_tracker.games
#   assert_equal 30, @stat_tracker.games.repo.count
#   assert_equal 3, @stat_tracker.games.repo.first.away_goals
# end

#for games across all time 
#use games.csv/repo 

def highest_total_score
  #max_by(each game(@home_score + @away_score)) 
  #total goals per game
  #module or instance method: total_score = sum(home + away)
  #@games.map {|game| sum(h + a)}
  #integer
end 

def lowest_total_score
  #min_by(each game(@home_score + @away_score))
  #integer
end 

def biggest_blowout
  #max_buy(each game(@home_score - @away_score))
  #integer
end 

def percentage_home_wins 
  #total_home_wins = games where home_goals > away_goals
  #total_home_wins/total_games 
  #float, round(2)
end

def percentage_visitor_wins
  #(100 - percentage_home_wins)
  #float, round(2)
end

def count_of_games_by_season(season) #to to go module? 
  #hash of season_names (20122013) as keys, #count_of_games as values 
end 

def average_goals_per_game 
  #(total_goals_all_seasons)/total_games_all_seasons
  #float, round(2)
end 

def average_goals_by_season(season)
  #season.total_goals/season.total_games 
  #hash with season_names as keys and a float.round(2) representing average number of goals in a game for that season as a value (spec says key? double check with Amy/Brian)
end 

#module: count of games, team, wins and losses, games each team, home vs away, games per season, 
