require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.new
  end


  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

end
