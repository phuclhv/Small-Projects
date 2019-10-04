class AddTakenOrderToStudentLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :student_lessons, :taken_order, :integer
  end
end
