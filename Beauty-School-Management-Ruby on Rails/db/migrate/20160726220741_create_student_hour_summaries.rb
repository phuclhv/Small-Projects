class CreateStudentHourSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :student_hour_summaries do |t|
      t.integer :month
      t.integer :year
      t.decimal :monthly_total
      t.decimal :to_date_total
      t.decimal :remaining_required
      t.decimal :previous_to_date_total
      t.references :activity, foreign_key: true
      t.references :school_user, foreign_key: true

      t.timestamps
    end
  end
end
