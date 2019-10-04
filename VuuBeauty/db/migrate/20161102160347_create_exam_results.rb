class CreateExamResults < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_results do |t|
      t.integer :exam_id
      t.integer :score
      t.string :answer_keys
      t.references :student_lesson, foreign_key: true

      t.timestamps
    end
  end
end
