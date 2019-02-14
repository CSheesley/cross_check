# Each of the methods below take a team id as an argument. Using that team id,
# your instance of StatTracker will provide statistics for a specific team.

module TeamStats

  def team_info(team_id) # probably a module
    @teams.repo.group_by do |team|
      if team.team_id == team_id
        return team
      end
      team
    end
    # team_info should be a hash output with 6 key value pairs
  end

#GAME_TEAM_CSV
    def all_games_played(team_id) #helper
      list = []
      @game_teams.repo.find_all do |game_team|
        if game_team.team_id == team_id
          list << game_team
        end
      end
      return list
    end

    def all_game_ids_by_team(team_id)
      all_game_ids = []
      all_games_played(team_id).find_all do |game_team|
        all_game_ids << game_team.game_id
      end
      all_game_ids
    end

    def seasons(team_id) #helper
      #use Carrie's array of all game id's for given team? (remove helper method above)
      all_game_ids_by_team(team_id)
      years = all_game_ids_by_team(team_id).map do |game_id|
        game_id.to_s.slice(0,4).to_i
      end
      years.uniq
    end
#
#     def wins_per_year(team_id) #helper
#       use method alredy all_wins_by_team(17)
#       rethink below
#       wins = {}
#       wins = find all "TRUE" responses to won? Count
#       store as a hash?
#       wins {2014: 50, 2015: 42}
#     end
#
#     def games_per_year(team_id)
#       games = {}
#       games = all_games_payed.group by |game|
#         game_id. (first four charactes of string)
#       create a hash with year and count of games
#     end
#
#     def win_percentage_by_season(team_id) #helper
#       yearly_win_percentage = {}
#       wins_per_year(team_id) / games_per_year(team_id)
#       store as a hash with year and win percentage
#       yearly_win_percentage = {2014: 60.0, 2015: 55.3}
#     end
#
#   def best_season(team_id)
#     placeholder = win_percentage_by_season(team_id).to_a
#     ex {2014: 60.0, 2015: 55.3}
#     ex [[2014: 60.0], [2015, 55.3]]
#
#     placeholder.min_by do |element|
#       element[1]
#     Season with the highest win percentage for a team. (as an integer)
#     return the season year? If so parse out [0] (year) of returned array.
#   end
#
#   def worst_season(team_id)
#     placeholder = win_percentage_by_season(team_id).to_a
#     ex {2014: 60.0, 2015: 55.3}
#     ex [[2014: 60.0], [2015, 55.3]]
#
#     placeholder.min_by do |element|
#       element[1]
#     Season with the lowest win percentage for a team. (as an integer)
#     return the season year? If so parse out [0] (year) of returned array.
#   end
#
#   def average_win_percentage(team_id)
#     placeholder = win_percentage_by_season(team_id).values
#     placeholder.sum do |element|
#       element
#     end
#     (placeholder / placeholder.count).to_f
#   end
#
#   def most_goals_scored(team_id)
#     all_games_payed(team_id).max do |game|
#       game.goals
#   end
#
#   def fewest_goals_scored(team_id)
#     all_games_payed(team_id).min do |game|
#       game.goals
#   end
#
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
    blow_out_total = []


    list = all_games_played.find_all do |game|
      game.won? = "TRUE"

    new list = []
    reference list in GAME CSV to find greatest difference between home and
    away goals.

    If home == team_id then home goals - away goals
    else away goals - home goals

    find max
  end
#
#   def worst_loss(team_id)
#     #GAME_TEAM CSV
#     list = all_games_played.find_all do |game|
#       game.won? = "FALSE"
#
#     new list = []
#     reference list in GAME CSV to find greatest difference between home and
#     away goals.
#
#     If hoa = home then away - home
#     else home - away
#
#     find max
#   end
#
def all_wins_by_team(team_id) #helper
  all_wins = []
  all_games_played(team_id).each do |game_team|
    if game_team.won?
      all_wins << game_team
    end
  end
  all_wins
end

def all_losses_by_team(team_id) #helper
  all_losses = []
  all_games_played(team_id).each do |game_team|
    if game_team.won? == false
      all_losses << game_team
    end
  end
  all_losses
end

#   def head_to_head(team_id)
#     may need to take in an additional team_id argument?
#     find all games between these two teams
#     find win and loss count verse opponent
#     return in a hash win/loss vs opponent
#     ex? {wins: 20, losses: 15}
#   end
#
#   def seasonal_summary(team_id)
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
