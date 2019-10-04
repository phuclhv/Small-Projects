class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.date :payment_date
      t.references :school_user, foreign_key: true

      t.timestamps
    end
  end
end
