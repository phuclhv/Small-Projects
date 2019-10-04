class AlterColumnStudentHoursSummaryMonthlyTotal < ActiveRecord::Migration[5.0]
  def change
    change_column :student_hour_summaries, :monthly_total, :float
    change_column :student_hour_summaries, :to_date_total, :float
    change_column :student_hour_summaries, :remaining_required, :float
    change_column :student_hour_summaries, :previous_to_date_total, :float
  end
end
