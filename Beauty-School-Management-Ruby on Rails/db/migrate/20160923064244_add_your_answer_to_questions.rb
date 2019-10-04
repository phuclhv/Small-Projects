class AddYourAnswerToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :your_answer, :string
  end
end
