module TeamStats

  def team_info(team_id)
    get_team_info(team_id)
    info_hash = {
      "team_id" => get_team_info(team_id).team_id,
      "franchise_id" => get_team_info(team_id).franchise_id,
      "short_name" => get_team_info(team_id).short_name,
      "team_name" => get_team_info(team_id).team_name,
      "abbreviation" => get_team_info(team_id).abbreviation,
      "link" => get_team_info(team_id).link
    }
  end

  def get_team_info(team_id) #helper
    @teams.repo.find do |team|
      team.team_id == team_id
    end
  end

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

  def win_percentage_by_season(team_id) #helper
    season_win_percentage = {}
    all_seasons(team_id).each do |year|
      season_win_percentage[year] =
      ((win_count_per_year(team_id)[year].to_f / game_count_per_year(team_id)[year]))
    end
    season_win_percentage
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

  def all_game_ids_by_team(team_id) #helper
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

  def game_count_per_year(team_id) #helper
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

  # def convert_season_to_season_span(year) #potential helper - needs to be built
  #   year = year.first
  #   @games.repo.find do |game|
  #       year.to_s == game.season.to_s.slice(0,4)
  #       return game.season.to_s
  #     end
  # end

  def most_goals_scored(team_id)
    all_goals(team_id).max
  end

  def fewest_goals_scored(team_id)
    all_goals(team_id).min
  end

  def all_goals(team_id) #helper
    all = all_games_played(team_id).map do |game|
      game.goals
    end
  end

  def favorite_opponent(team_id)
    favorite = head_to_head(team_id).max_by {|team, percentage| percentage}
    favorite.first
  end

  def rival(team_id)
    rival = head_to_head(team_id).min_by {|team, percentage| percentage}
    rival.first
  end

def biggest_team_blowout(team_id)
  game_ids = win_game_ids(team_id)
  max_goal_differential_from_games(game_ids)
end

def worst_loss(team_id)
  game_ids = loss_game_ids(team_id)
  max_goal_differential_from_games(game_ids)
end

def max_goal_differential_from_games(game_ids) #helper
  game_goals = @games.repo.find_all do |game|
    game_ids.include?(game.game_id)
  end
  max_goal_differential(game_goals)
end

def max_goal_differential(game_goals) #helper
  differential = []
  game_goals.each do |game|
    differential << (game.away_goals - game.home_goals).abs
  end
  differential.max
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

def win_game_ids(team_id) #helper
  all_wins_by_team(team_id).map do |win| #repeats
    win.game_id
  end
end

def loss_game_ids(team_id) #helper
  all_losses_by_team(team_id).map do |loss| #repeats
    loss.game_id
  end
end

def head_to_head(team_id)
  win_percentage_by_team = {}
  all_wins_vs_opponent(team_id).each do |team_name, wins|
    win_percentage_by_team[team_name] = ((wins.to_f / all_games_vs_opponent(team_id)[team_name]).round(2))
  end
  win_percentage_by_team
end

def all_wins_vs_opponent(team_id) #helper
   @game_ids = @games.repo.find_all do |game| #break into helper
    win_game_ids(team_id).include?(game.game_id)
     end
    populate_list
    count_by_team_name(team_id)
end

def all_games_vs_opponent(team_id) #helper
    @game_ids = @games.repo.find_all do |game| #break into helper
    all_game_ids_by_team(team_id).include?(game.game_id)
      end
    populate_list
    count_by_team_name(team_id)
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

#   end
#
end
