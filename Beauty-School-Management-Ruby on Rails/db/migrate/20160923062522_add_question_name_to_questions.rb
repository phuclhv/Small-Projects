class AddQuestionNameToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :question_name, :string
  end
end
