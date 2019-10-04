class RemoveSchoolUserFromAddresses < ActiveRecord::Migration[5.0]
  def change
    #remove_column :addresses, :school_user_id, :string
    remove_foreign_key :addresses, column: :school_user_id
  end
end
