class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.integer :chapter_number
      t.string :chapter_name
      t.integer :lesson_number
      t.string :lesson_name
      t.string :book_name
      t.integer :page_number
      t.references :study_program, foreign_key: true

      t.timestamps
    end
  end
end
