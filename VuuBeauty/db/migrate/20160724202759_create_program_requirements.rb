class CreateProgramRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :program_requirements do |t|
      t.integer :hours
      t.date :effective_date
      t.date :end_date
      t.references :study_program, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
