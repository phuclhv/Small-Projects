class AddAddressToSchool < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :address, :string
    add_column :schools, :city, :string
    add_column :schools, :zipcode, :string
    add_column :schools, :phone, :string
    add_column :schools, :email, :string
  end
end

#School.all.where(id: 1).update_all(address: "807 S. King St", city: "Seattle", zipcode: "98104", phone: "(206) 340-2655", email: "vuubeautyschool@gmail.com")