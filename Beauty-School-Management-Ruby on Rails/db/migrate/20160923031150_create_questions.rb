class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :question_number
      t.string :answer_key
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
