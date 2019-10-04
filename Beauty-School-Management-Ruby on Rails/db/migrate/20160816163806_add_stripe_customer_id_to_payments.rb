class AddStripeCustomerIdToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :stripe_customer_id, :integer
  end
end
