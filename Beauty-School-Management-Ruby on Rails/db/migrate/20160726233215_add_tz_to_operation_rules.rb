class AddTzToOperationRules < ActiveRecord::Migration[5.0]
  def change
    add_column :operation_rules, :tz, :string
  end
end
