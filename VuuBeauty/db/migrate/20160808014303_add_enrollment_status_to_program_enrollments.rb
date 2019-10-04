class AddEnrollmentStatusToProgramEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_reference :program_enrollments, :enrollment_status, foreign_key: true
  end
end
