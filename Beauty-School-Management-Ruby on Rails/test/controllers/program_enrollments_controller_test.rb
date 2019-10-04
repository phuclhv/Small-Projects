require 'test_helper'

class ProgramEnrollmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get program_enrollments_new_url
    assert_response :success
  end

  test "should get create" do
    get program_enrollments_create_url
    assert_response :success
  end

end
