module TeamStats

  def team_info(team_id) # probably a module
    @teams.repo.group_by do |team|
      if team.team_id == team_id
        return team
      end
      team
    end
    # team_info should be a hash output with 6 key value pairs,
    # currently has 7 including parent.
  end

  def all_games_played(team_id) #helper
    list = []
    @game_teams.repo.find_all do |game_team|
      if game_team.team_id == team_id
        list << game_team
      end
    end
    list
  end

  def all_game_ids_by_team(team_id)
    all_game_ids = []
    all_games_played(team_id).find_all do |game_team|
      all_game_ids << game_team.game_id
    end
    all_game_ids
  end

  def all_seasons(team_id) #helper
    all_game_ids_by_team(team_id)
    years = all_game_ids_by_team(team_id).map do |game_id|
      game_id.to_s.slice(0,4).to_i #game_id_to_year method
    end
    years.uniq
  end

  def game_team_wins_by_year(team_id) #helper
    all_wins_by_team(team_id).group_by do |game_team|
      game_team.game_id.to_s.slice(0,4) #game_id_to_year method
    end
  end

  def win_count_per_year(team_id) #helper
    wins_per_year = {}
    game_team_wins_by_year(team_id).each do |year, game_teams|
      wins_per_year[year.to_i] = game_teams.count
    end
    wins_per_year
  end

  def game_team_games_by_year(team_id) #helper
    all_games_played(team_id).group_by do |game_team|
      game_team.game_id.to_s.slice(0,4)  #game_id_to_year method
    end
  end

  def game_count_per_year(team_id)
    games_per_year = {}
    game_team_games_by_year(team_id).each do |year, game_teams|
      games_per_year[year.to_i] = game_teams.count
    end
    games_per_year
  end

  # trouble incorporating
  # def game_id_to_year #helper
  #   game_id.to_s.slice(0,4)
  # end

  def win_percentage_by_season(team_id) #helper
    season_win_percentage = {}
    all_seasons(team_id).each do |year|
      season_win_percentage[year] = ((win_count_per_year(team_id)[year].to_f / game_count_per_year(team_id)[year]) * 100)
    end
    season_win_percentage
  end

  # #trouble incorporating
  # def annual_win_percentage(team_id) #helper
  #   (win_count_per_year(team_id)[year]/game_count_per_year(team_id)[year])
  # end

  def best_season(team_id)
    seasons = win_percentage_by_season(team_id).to_a
    seasons.max_by do |year_percent|
      year_percent[1]
    end.first
  end

  def worst_season(team_id)
    seasons = win_percentage_by_season(team_id).to_a
    seasons.min_by do |year_percent|
      year_percent[1]
    end.first
  end

  def average_win_percentage(team_id)
    percentages = []
    win_percentage_by_season(team_id).each do |year, percent|
      percentages << percent
    end
      percentages.inject(0.0) {|sum, percentage| sum + percentage} / percentages.count
  end

  def most_goals_scored(team_id)
    all_goals(team_id).max
  end

  def fewest_goals_scored(team_id)
    all_goals(team_id).min
  end

  def all_goals(team_id)
    all = all_games_played(team_id).map do |game|
      game.goals
    end
  end

#   def favorite_opponent(team_id)
#     team played the most times?
#   end
#
#   def rival(team_id)
#     listed somewhere? Didnt see on team info csv
#   end
#
# #GAME_CSV
#
def biggest_team_blowout(team_id)
  win_game_ids(team_id)
   win_games = @games.repo.find_all do |game|
     win_game_ids(team_id).include?(game.game_id)
     end
      win_differential = []
      win_games.each do |win|
        win_differential << (win.away_goals - win.home_goals).abs
      end
      win_differential.max
end

def worst_loss(team_id)
  loss_game_ids = all_losses_by_team(team_id).map do |loss| #break into a helper
    loss.game_id
  end
   loss_games = @games.repo.find_all do |game|
     loss_game_ids.include?(game.game_id)
     end
      loss_differential = []
      loss_games.each do |loss|
        loss_differential << (loss.away_goals - loss.home_goals).abs
      end
      loss_differential.max
end

def all_wins_by_team(team_id) #helper
  all_games_played(team_id).find_all do |game_team|
    game_team.won?
    end
end

def all_losses_by_team(team_id) #helper
  all_games_played(team_id).find_all do |game_team|
    game_team.won? == false
    end
end

def head_to_head(team_id)
  win_percentage_by_team = {}
  all_wins_vs_opponent(team_id).each do |team_name, wins|
    win_percentage_by_team[team_name] = ((wins.to_f / all_games_vs_opponent(team_id)[team_name]).round(2))
  end
  win_percentage_by_team
end

# def win_percentage_by_season(team_id) #helper
#   season_win_percentage = {}
#   all_seasons(team_id).each do |year|
#     season_win_percentage[year] = ((win_count_per_year(team_id)[year].to_f / game_count_per_year(team_id)[year]) * 100)
#   end
#   season_win_percentage
# end




def all_wins_vs_opponent(team_id) #helper
  win_game_ids(team_id)
   @game_ids = @games.repo.find_all do |game| #break into helper
     win_game_ids(team_id).include?(game.game_id)
     end
    populate_list
    count_by_team_name(team_id)
end

def all_games_vs_opponent(team_id)
    @game_ids = @games.repo.find_all do |game| #break into helper
      all_game_ids_by_team(team_id).include?(game.game_id)
      end
    populate_list
    count_by_team_name(team_id)
end

def win_game_ids(team_id)
  all_wins_by_team(team_id).map do |win| #break into a helper
    win.game_id
  end
end

def populate_list #helper
  @all_teams = []
  @game_ids.each do |game|
    @all_teams << game.away_team_id << game.home_team_id
  end
end

def count_by_team_name(team_id) #helper
  count_by_team_name = {}
  opponents = @all_teams.reject { |team| team == team_id }
  opponents.each do |team|
    count_by_team_name[team_id_swap(team)] = opponents.count(team)
  end
  count_by_team_name
end





# def seasonal_summary(team_id)
#     may need a lot of total stat by year helpers?
#
#
#     example output{
#     2014:
#       {{preseason: total_goals_scored,:total_goals_against,
#         :average_goals_scored, :average_goals_against},
#       {regular_season: total_goals_scored,:total_goals_against,
#       :average_goals_scored, :average_goals_against }},
#     2015:
#       {{preseason: total_goals_scored,:total_goals_against,
#         :average_goals_scored, :average_goals_against},
#       {regular_season: total_goals_scored,:total_goals_against,
#       :average_goals_scored, :average_goals_against }},
#     }
#
#   end
#

end
