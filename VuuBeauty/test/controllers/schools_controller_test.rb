require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "should get schools index as admin user" do
    log_in_as(@admin)
    get schools_path
    assert_response :success
  end
  
  test "should not get schools index as admin user" do
    log_in_as(@non_admin)
    get schools_path
    assert_redirected_to root_url
  end
end
