class RemoveCellPhoneFromSchoolUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :school_users, :cell_phone, :string
  end
end
