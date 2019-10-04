require 'test_helper'

class StateTest < ActiveSupport::TestCase
  def setup
    @wa = states(:wa)
    @admin = users(:michael) 
  end
  
  test "WA state should be valid" do
    assert @wa.valid?
  end
  
  test "State field 2-char code should be present and in Uppercase" do
    @wa.state = nil
    assert_not @wa.valid?
    mixed_case_state = "Wa"
    @wa.state = mixed_case_state
    @wa.save
    assert_equal mixed_case_state.upcase, @wa.state
    assert_equal mixed_case_state.length, @wa.state.length
    @wa.state = "W"
    assert_not @wa.valid?
  end
end