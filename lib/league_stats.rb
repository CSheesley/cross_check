module LeagueStats

  def make_team_id_hash
    hash = {}
    ordered = @teams.repo.sort_by do |team|
      team.team_id
    end
    @teams.repo.each do |team|
      hash[team.team_id] = team.team_name
    end
    hash
  end

  def team_id_swap(input)
    if input.class == Integer
      output = @teams.repo.find do |team|
        team.team_id == input
      end
      return output.team_name
    else
      input.capitalize!
      output = @teams.repo.find do |team|
        team.team_name == input
      end
      return output.team_id
    end
  end

  def array_of_teams
    list = array_of_team_ids
    list.map do |team|
      team_id_swap(team)
    end
  end

  def array_of_team_ids
    list = @game_teams.repo.map do |game_team|
      game_team.team_id
    end
    list.uniq!
  end

  def count_of_teams
    list = array_of_teams
    list.count
    # @teams.repo.count
  #   total number of teams - should be module
  #   returns an integer
  end

  def get_all_game_teams_for_team(team)
    id = team_id_swap(team)
    list = @game_teams.repo.find_all do |game_team|
      game_team.team_id == id
    end
    list
  end

  def get_all_opponents_game_team_data(team)
    current = get_all_game_teams_for_team(team)
    list = []
    current.each do |game|
      @game_teams.repo.each do |game_team|
        if game.game_id == game_team.game_id
          list << game_team
        end
      end
    end
    opponents = list.reject do |game_team|
      game_team.team_id == team_id_swap(team)
    end
  end
  #

  def total_points_for_team(team)
    id = team_id_swap(team)
    total = 0
    @game_teams.repo.each do |game_team|
      if game_team.team_id == id
        total += game_team.goals
      end
    end
    total.to_f
  end

  def total_points_against(team)
    id = team_id_swap(team)
    game_teams = get_all_opponents_game_team_data(team)
    total = 0
    game_teams.each do |game_team|
      total += game_team.goals
    end
    total.to_f
  end

  def best_offense
    list = array_of_teams
    team = list.max_by do |team_name| #for each team_name in hash
      highest_avg = 0
      total_points = total_points_for_team(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  #   highest avg goals/game all seasons
  #   highest average_goals_per_game  inherit!
  #
  #   returns string of team name
  end
  #
  def worst_offense
    list = array_of_teams
    team = list.min_by do |team_name|
      highest_avg = 0
      total_points = total_points_for_team(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  #   lowest avg goals/game all seasons
  #   lowest average_goals_per_game inherit!
  #
  #   returns string of team name
  end
  #
  def best_defense
    list = array_of_teams
    team = list.min_by do |team_name|
      lowest_avg = nil
      total_points = total_points_against(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        lowest_avg = total_points / total_games
      end
      lowest_avg
    end
    team
    # get_all_opponents_game_team_data
  #   lowest average_goals_per_game against
  #
  #   lowest avg goals/game *allowed* all seasons
  #   teamgame.each do |game| #when home
  #     total += away_goals
  #   teamgame.each do |game| #when away
  #     total += home_goals
  #
  #   returns string of team name
  end
  #
  def worst_defense
    list = array_of_teams
    team = list.max_by do |team_name|
      highest_avg = nil
      total_points = total_points_against(team_name)
      total_games = get_all_game_teams_for_team(team_name).count
      if get_all_game_teams_for_team(team_name).count > 0
        highest_avg = total_points / total_games
      end
      highest_avg
    end
    team
  #   highest average_goals_per_game against
  #
  #   highest avg goals/game *allowed* all seasons
  #   teamgame.each do |game| #when home
  #     total += away_goals
  #   teamgame.each do |game| #when away
  #     total += home_goals
  #
  #   returns string of team name
  end
  #
  #
  def highest_scoring_visitor
    list = array_of_teams
    team = list.max_by do |team_name|
      total_away_goals = 0
      aways = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "home"
      end
      aways.each do |game|
        total_away_goals += game.goals
      end
      total_away_goals
    end
    team

  #   highest average away score all seasons
  #
  #   if team == away
  #     average goals
  #
  #   returns string of team name
  end
  #
  def lowest_scoring_visitor
    list = array_of_teams
    team = list.min_by do |team_name|
      total_away_goals = 0
      aways = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "home"
      end
      aways.each do |game|
        total_away_goals += game.goals
      end
      total_away_goals
    end
    team
    #   lowest average away score all seasons
    #
    #   if team == away
    #     average goals
    #
    #   returns string of team name
  end
  #
  def highest_scoring_home_team
    list = array_of_teams
    team = list.max_by do |team_name|
      total_home_goals = 0
      homes = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "away"
      end
      homes.each do |game|
        total_home_goals += game.goals
      end
      total_home_goals
    end
  #   highest average home score all seasons
  #
  #   if team == home
  #     average goals
  #   returns string of team name
  end
  #
  def lowest_scoring_home_team
    list = array_of_teams
    team = list.min_by do |team_name|
      total_home_goals = 0
      homes = get_all_game_teams_for_team(team_name).reject do |game|
        game.home_or_away == "away"
      end
      homes.each do |game|
        total_home_goals += game.goals
      end
      total_home_goals
    end
  #   lowest average home score all seasons
  #
  #   if team == home
  #     average goals
  #
  #   returns string of team name
  end
  #
  def winningest_team
  #   highest win percentage all seasons
  #   (wins away + wins home) / total games
  #   returns string of team name
  end
  #
  def best_fans
    # largest (home win perc. - away win perc.) all seasons
  #   (home_wins / total_games) - (away_wins / total_games)
  #   returns string of team name
  end
  #
  def worst_fans
  #   away win perc. > home win perc.
  #   returns array of team names(strings)
  end
end
