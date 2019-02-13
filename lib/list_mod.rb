module List

  def list_seasons(repo) #use games repo
    seasons = repo.map do |game|
      game.season
    end
    seasons.uniq!
  end

  def list_teams_per_season(repo) #use games repo
    teams = Hash.new {|hash,keys| hash[keys] = []}
    repo.each do |game|
      teams[game.season] << game.team_id
    end

  end

  def list_games_per_team(repo) #use games repo


  end

  def list_home_games_per_team

  end

  def list_away_games_per_team

  end
end
