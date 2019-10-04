class RemoveHomePhoneFromSchoolUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :school_users, :home_phone, :string
  end
end
