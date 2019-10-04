require 'test_helper'

class WebChargesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get web_charges_new_url
    assert_response :success
  end

  test "should get create" do
    get web_charges_create_url
    assert_response :success
  end

end
