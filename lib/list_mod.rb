module List
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
    team.class == String ? id = team_id_swap(team) : id = team
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




  def win_percentage(team,game_team_array)
    games = game_team_array
    wins = won_games(team)
    pct = (wins.count.to_f * 100 / games.count).round(2)
  end

  def loss_percentage(team,game_team_array)
    games = game_team_array
    loss = lost_games(team)
    pct = (loss.count.to_f * 100 / games.count).round(2)
  end
end
