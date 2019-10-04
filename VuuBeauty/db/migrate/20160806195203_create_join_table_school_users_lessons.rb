class CreateJoinTableSchoolUsersLessons < ActiveRecord::Migration[5.0]
  def change
    create_join_table :lessons, :school_users,
          table_name: :student_lessons, column_options: { null: true } do |t|
      t.index :school_user_id
      t.index :lesson_id
    end
    
    # Has the student completed the lesson?
    add_column :student_lessons, :completed, :boolean, default: :false
    # Should we show the lesson to the student?
    add_column :student_lessons, :visible,   :boolean, default: :false
    # Should we enable the student to take the lesson?
    add_column :student_lessons, :enabled,   :boolean, default: :false
  end
end
