class AlterColumnStudentHoursDailyHour < ActiveRecord::Migration[5.0]
  def change
    change_column :student_hours, :daily_hour, :float
  end
end
