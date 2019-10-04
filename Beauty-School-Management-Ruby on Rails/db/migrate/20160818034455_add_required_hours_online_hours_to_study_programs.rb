class AddRequiredHoursOnlineHoursToStudyPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :study_programs, :required_hours, :integer
    add_column :study_programs, :online_hours, :integer
  end
  #StudyProgram.all.where(id: 1).update_all(required_hours: 1600, online_hours: 400)
  #StudyProgram.all.where(id: 2).update_all(required_hours: 1000, online_hours: 250)
  #StudyProgram.all.where(id: 3).update_all(required_hours:  600, online_hours: 150)
  #StudyProgram.all.where(id: 5).update_all(required_hours:  500, online_hours: 125)
  #StudyProgram.all.where(id: 7).update_all(required_hours:  750, online_hours: 187)
  #StudyProgram.all.where(id: 8).update_all(required_hours: 1400, online_hours: 350)
end
