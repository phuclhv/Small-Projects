class CreateStudyPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :study_programs do |t|
      t.string :title
      t.integer :months
      t.integer :tuition

      t.timestamps
    end
  end
end
