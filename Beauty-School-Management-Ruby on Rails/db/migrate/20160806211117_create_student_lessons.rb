class CreateStudentLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :student_lessons do |t|
      t.boolean :visible,     default: :false
      t.boolean :enabled,     default: :false
      t.boolean :completed,   default: :false
      t.integer :taken_order
      t.references :school_user, foreign_key: true
      t.references :lesson, foreign_key: true

      t.timestamps
    end
    
    add_index :student_lessons, [:school_user_id, :lesson_id, :taken_order], unique: true, name: "student_lessons_user_lesson_taken_uniq"
  end
end
