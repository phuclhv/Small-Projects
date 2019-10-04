require 'test_helper'

class StudentHourSummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_hour_summaries_index_url
    assert_response :success
  end

end
