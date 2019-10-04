class CreateSchoolUserTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :school_user_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
