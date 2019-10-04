require 'test_helper'

class TimecardTest < ActiveSupport::TestCase

  def setup
    @student = users(:archer)
  end
  
  test "should be valid" do
    @timecard = @user.school_users.timecards.build(clock_in: Time.zone.now)
    assert @timecard.valid?
  end

  test "user id should be present" do
    @timecard = @user.school_users.timecards.build(clock_in: Time.zone.now)
    @timecard.user_id = nil
    assert_not @timecard.valid?
  end
  
  test "clock_in should be present" do
    @timecard = @user.school_users.timecards.build(clock_in: Time.zone.now)
    @timecard.clock_in = nil
    assert_not @timecard.valid?
  end
  
  test "order should be most recent first" do
    assert_equal timecards(:most_recent), Timecard.first
  end
  
  test "associated time cards should be destroyed" do
    @user.save
    @user.school_users.timecards.create!(clock_in: Time.zone.now)
    assert_difference 'Timecard.count', -1 do
      @user.destroy
    end
  end
end
