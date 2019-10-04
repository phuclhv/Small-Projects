class AddSchoolUserToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :school_user, foreign_key: true
  end
end
