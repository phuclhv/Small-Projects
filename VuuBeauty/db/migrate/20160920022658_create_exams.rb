class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :document_path
      t.references :lesson, foreign_key: true

      t.timestamps
    end
  end
end
