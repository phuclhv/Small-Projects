class DropJoinTableStudentLessons < ActiveRecord::Migration[5.0]
  def change
    drop_join_table :lessons, :school_users, table_name: :student_lessons
  end
end
