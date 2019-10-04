require 'test_helper'

class StudyProgramTest < ActiveSupport::TestCase
  def setup
    @school = schools(:vuu)
    @study_program = @school.study_programs.build(title: "Cosmo", months: 12, tuition: 6500)
  end
  
  test "should be valid" do
    assert @study_program.valid?
  end
  
  test "school id should be present" do
    @study_program.school_id = nil
    assert_not @study_program.valid?
  end
end
