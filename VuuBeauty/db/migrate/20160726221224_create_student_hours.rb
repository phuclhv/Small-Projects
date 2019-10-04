class CreateStudentHours < ActiveRecord::Migration[5.0]
  def change
    create_table :student_hours do |t|
      t.decimal :daily_hour
      t.boolean :processed,   default: false
      t.references :calendar, foreign_key: true
      t.references :activity, foreign_key: true
      t.references :timecard, foreign_key: true
      t.references :school_user, foreign_key: true

      t.timestamps
    end
  end
end
