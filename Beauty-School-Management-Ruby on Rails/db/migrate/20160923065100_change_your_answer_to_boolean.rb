class ChangeYourAnswerToBoolean < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :your_answer, 'boolean USING your_answer::boolean'
  end
end
