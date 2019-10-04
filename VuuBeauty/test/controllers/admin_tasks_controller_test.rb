require 'test_helper'

class AdminTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get new_payment" do
    get admin_tasks_new_payment_url
    assert_response :success
  end

end
