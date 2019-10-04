require 'test_helper'

class StudyProgramsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "should get study programs index as admin user" do
    log_in_as(@admin)
    get study_programs_path
    assert_response :success
  end
  
  test "should not get study programs index as non admin user" do
    log_in_as(@non_admin)
    get study_programs_path
    assert_redirected_to root_url
  end

end
