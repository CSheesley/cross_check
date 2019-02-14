class SeasonStats

  def biggest_bust
    # max (preseason win %) - (regular win %) => decrease
    #FOR GIVEN SEASON
    #string of team name
  end


  def biggest_suprise
    #max (regular win %) - (preseason win %) => increase
    #FOR GIVEN SEASON
    #string of team name
  end


  def winningest_coach
    #coach of best win % for SEASON
    #string of coach name
  end


  def worst_coach
    #coach of worst win % for SEASON
    #string of coach name
  end



  def most_accurate_team
    # min_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def least_accurate_team
    # max_by ratio of shots on goal to goals shots:goals
    #string of team name
  end


  def most_hits
    #team with most hits
    #IN GIVEN SEASON
    #string of team name
  end


  def least_hits
    #team with fewest hits
    #IN GIVEN SEASON
    #string of team name
  end


  def power_play_goal_percentage
    # 100 * power_play_goals / total goals round(2) for ALL TEAMS
    #IN GIVEN SEASON
    #float of percentage
  end

end
