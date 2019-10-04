class AddSchoolToStudyPrograms < ActiveRecord::Migration[5.0]
  def change
    add_reference :study_programs, :school, foreign_key: true
  end
end
