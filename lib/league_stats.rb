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

  def count_of_teams
    list = array_of_teams
    list.count
    # @teams.repo.count
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

  def get_team_home_games(team)
    games = get_all_game_teams_for_team(team)
    home = games.reject do |game|
      game.home_or_away == "away"
    end
  end

  def get_team_away_games(team)
    games = get_all_game_teams_for_team(team)
    home = games.reject do |game|
      game.home_or_away == "home"
    end
  end

  def won_games(team)
    games = get_all_game_teams_for_team(team)
    won = games.reject do |game|
      game.won? == false
    end
  end


  def lost_games(team)
    games = get_all_game_teams_for_team(team)
    lost = games.reject do |game|
      game.won? == true
    end
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
  end

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
  end

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
  end

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
  end

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
  end

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
  end

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
  end

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
  end

  def win_percentage(team)
    games = get_all_game_teams_for_team(team)
    wins = won_games(team)
    pct = (wins.count.to_f * 100/ games.count).round(2)
  end


  def loss_percentage(team)
    games = get_all_game_teams_for_team(team)
    loss = lost_games(team)
    pct = (loss.count.to_f * 100/ games.count).round(2)
  end

  def winningest_team
    list = array_of_teams
    list.max_by do |team_name|
      win_percentage(team_name)
    end
  end

  def best_fans
    list = array_of_teams
    best = list.max_by do |team|
        home_wins = get_team_home_games(team) & won_games(team)
      away_wins = get_team_away_games(team) & won_games(team)
      home_wins.count - away_wins.count
    end
  end

  def worst_fans
    list = array_of_teams
    worst = list.find_all do |team|
      home_wins = (get_team_home_games(team) & won_games(team)).count.to_f * 100 / get_team_home_games(team).count
      away_wins = (get_team_home_games(team) & won_games(team)).count.to_f * 100 / get_team_home_games(team).count
      home_wins < away_wins
    end
  end
end
