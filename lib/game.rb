require "./lib/game_repo"

class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :outcome, :home_rink_side_start, :venue, :venue_link, :venue_time_zone_id, :venue_time_zone_offset, :venue_time_zone_tz, :parent
  def initialize(info,parent)
    @game_id = info[:game_id].to_i
    @season = info[:season].to_i
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id].to_i
    @home_team_id = info[:home_team_id].to_i
    @away_goals = info[:away_goals].to_i
    @home_goals = info[:home_goals].to_i
    @outcome = info[:outcome]
    @home_rink_side_start = info[:home_rink_side_start]
    @venue = info[:venue]
    @venue_link = info[:venue_link]
    @venue_time_zone_id = info[:venue_time_zone_id]
    @venue_time_zone_offset = info[:venue_time_zone_offset].to_i
    @venue_time_zone_tz = info[:venue_time_zone_tz]

    @parent = parent
  end
end
