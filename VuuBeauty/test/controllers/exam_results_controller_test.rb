require 'test_helper'

class ExamResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exam_results_index_url
    assert_response :success
  end

end
