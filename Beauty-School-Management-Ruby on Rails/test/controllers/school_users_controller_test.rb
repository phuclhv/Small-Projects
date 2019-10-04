require 'test_helper'

class SchoolUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get school_users_path
    assert_response :success
  end
end
