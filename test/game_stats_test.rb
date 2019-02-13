def test_stat_tracker_can_return_lowest_and_highest_total_scores
  skip
  Expected = integer
  assert_equal Expected, @stat_tracker.lowest_total_score
  assert_equal Expected, @stat_tracker.highest_total_score
end



# def test_stat_tracker_can_return_biggest_blowout
#   skip
#   Expected = integer
#   assert_equal Expected, @stat_tracker.biggest_blowout
# end

# def test_stat_tracker_can_return_home_and_visitor_team_percentage_wins
#   skip
#   Expected = float, round(2) # to the nearest one hundredth
#   assert_equal Expected, @stat_tracker.percentage_home_wins
#   assert_equal Expected, @stat_tracker.percentage_visitor_wins
# end

# def test_stat_tracker_can_return_count_of_games_by_season
#   skip
#   Expected = hash
#   assert_equal Expected, @stat_tracker.count_of_games_by_season
# end

# def test_stat_tracker_can_return_average_goals_per_game
#   skip
#   Expected = Float, round(2)
#   assert_equal Expected, @stat_tracker.average_goals_per_game
# end

# def test_stat_tracker_can_return_average_goals_by_season
#   skip
#   Expected = hash
#   assert_equal Expected, @stat_tracker.average_goals_by_season
# end
end
