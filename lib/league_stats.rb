module LeagueStats

  def count_of_teams
    @teams.count
  #   total number of teams - should be module
  #   returns an integer
  end

  #
  # def best_offense
  #   highest avg goals/game all seasons
  #   highest average_goals_per_game  inherit!
  #
  #   returns string of team name
  # end
  #
  # def worst_offense
  #   lowest avg goals/game all seasons
  #   lowest average_goals_per_game inherit!
  #
  #   returns string of team name
  # end
  #
  # def best_defense
  #   lowest average_goals_per_game against
  #
  #   lowest avg goals/game *allowed* all seasons
  #   teamgame.each do |game| #when home
  #     total += away_goals
  #   teamgame.each do |game| #when away
  #     total += home_goals
  #
  #   returns string of team name
  # end
  #
  # def worst_defense
  #   highest average_goals_per_game against
  #
  #   highest avg goals/game *allowed* all seasons
  #   teamgame.each do |game| #when home
  #     total += away_goals
  #   teamgame.each do |game| #when away
  #     total += home_goals
  #
  #   returns string of team name
  # end
  #
  #
  # def highest_scoring_visitor
  #   highest average away score all seasons
  #
  #   if team == away
  #     average goals
  #
  #   returns string of team name
  # end
  #
  # def highest_scoring_home_team
  #   highest average home score all seasons
  #
  #   if team == home
  #     average goals
  #   returns string of team name
  # end
  #
  # def lowest_scoring_visitor
  #   lowest average away score all seasons
  #
  #   if team == away
  #     average goals
  #
  #   returns string of team name
  # end
  #
  # def lowest_scoring_home_team
  #   lowest average home score all seasons
  #
  #   if team == home
  #     average goals
  #
  #   returns string of team name
  # end
  #
  # def winningest_team
  #   highest win percentage all seasons
  #   (wins away + wins home) / total games
  #   returns string of team name
  # end
  #
  # def best_fans
  #   largest (home win perc. - away win perc.) all seasons
  #   (home_wins / total_games) - (away_wins / total_games)
  #   returns string of team name
  # end
  #
  # def worst_fans
  #   away win perc. > home win perc.
  #   returns array of team names(strings)
  # end
end
