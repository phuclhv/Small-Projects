class RemoveSchoolUserIdFromAddresses < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :school_user_id, :Fixnum
  end
end
