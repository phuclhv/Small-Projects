class FixAnswerKeysColumnNameExamResults < ActiveRecord::Migration[5.0]
  def change
    rename_column :exam_results, :answer_keys, :answers
  end
end
