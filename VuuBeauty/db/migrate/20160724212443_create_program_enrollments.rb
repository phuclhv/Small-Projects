class CreateProgramEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :program_enrollments do |t|
      t.datetime :enrollment_date
      t.datetime :graduation_date
      t.boolean :brochure_received, default: true
      t.decimal :gpa
      t.integer :tuition_balance
      t.datetime :status_change_date
      t.boolean :transferred, default: false
      t.boolean :online, default: false
      t.references :school_user, foreign_key: true
      t.references :study_program, foreign_key: true

      t.timestamps
    end
  end
end
