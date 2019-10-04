require 'test_helper'

class TimecardsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @timecard = timecards(:most_recent)
    @user = users(:archer)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Timecard.count' do
      post timecards_path, params: { timecard: { clock_in: Time.zone.now } }
    end
    assert_redirected_to login_url
  end
  
  test "should be able to create timecard when logged in" do
    log_in_as(@user)
    get timecards_path
  end
end