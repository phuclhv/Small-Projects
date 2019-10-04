class CreateSchoolUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :school_users do |t|
      t.string :ssn
      t.date :dob
      t.string :home_phone
      t.string :cell_phone
      t.string :gender
      t.boolean :disability,  default: false
      t.boolean :veteran,     default: false
      t.boolean :newsletter,  default: false
      t.integer :appid
      t.references :school_user_type, foreign_key: true
      t.references :race, foreign_key: true
      t.references :education_level, foreign_key: true
      t.references :user, foreign_key: true
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
