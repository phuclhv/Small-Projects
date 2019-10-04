require 'test_helper'

class SchoolUserTest < ActiveSupport::TestCase

  def setup
    @user = users(:archer)
    @student = school_users(:archer)
  end

  test "should be valid" do
    assert @student.valid?
  end
  
  test "fk ids should be valid" do
    assert_not @student.race_id.nil?
  end
end
