require 'test_helper'

class StudentLessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get student_lessons_new_url
    assert_response :success
  end

  test "should get create" do
    get student_lessons_create_url
    assert_response :success
  end

end
