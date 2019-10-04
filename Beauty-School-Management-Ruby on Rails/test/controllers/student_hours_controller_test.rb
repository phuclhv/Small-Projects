require 'test_helper'

class StudentHoursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_hours_index_url
    assert_response :success
  end

end
