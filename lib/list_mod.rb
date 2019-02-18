module List

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
    if input.length < 3
      output = @teams.repo.find do |team|
        team.team_id == input
      end
      return output.team_name
    else
      output = @teams.repo.find do |team|
        team.team_name == input
      end
      return output.team_id
    end
  end


  def get_all_game_teams_for_team(team)
    team.length > 2 ? id = team_id_swap(team) : id = team
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
    list.reject do |game_team|
      game_team.team_id == team_id_swap(team)
    end
  end

  def find_game_teams_by_season(season)
    @game_teams.repo.find_all do |game_team|
      game_id_to_season(game_team.game_id) == season
    end
  end

  def find_games_by_season(season)
    @games.repo.find_all do |game|
      game.season == season
    end
  end

  def get_all_games(team)
    if team.length > 2
      team = team_id_swap(team)
    end
    @games.repo.find_all do |game|
      game.away_team_id == team || game.home_team_id == team
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
    team_id_swap(team)
    game_teams = get_all_opponents_game_team_data(team)
    total = 0
    game_teams.each do |game_team|
      total += game_team.goals
    end
    total.to_f
  end


  def get_team_home_games(team)
    games = get_all_game_teams_for_team(team)
    games.reject do |game|
      game.home_or_away == "away"
    end
  end

  def get_team_away_games(team)
    games = get_all_game_teams_for_team(team)
    games.reject do |game|
      game.home_or_away == "home"
    end
  end


  def won_game_teams(team)
    games = get_all_game_teams_for_team(team)
    games.reject do |game|
      game.won? == false
    end
  end


  def won_games(team)
    won_game_teams = won_game_teams(team)
    game_ids = won_game_teams.map do |game_team|
      game_team.game_id
    end
    all_games = get_all_games(team)
    all_games.find_all do |game|
      game_ids.include?(game.game_id)
    end
  end


  def regular_games(team)
    games = get_all_games(team)
    games.reject do |game|
      game.type == "P"
    end
  end

  def preseason_games(team)
    games = get_all_games(team)
    games.reject do |game|
      game.type == "R"
    end
  end


  def win_percentage(team,game_team_array)
    games = game_team_array
    wins = won_game_teams(team)
    (wins.count.to_f * 100 / games.count).round(2)
  end

end
