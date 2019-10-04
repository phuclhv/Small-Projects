class AddPhoneToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :phone, :string
  end
end
