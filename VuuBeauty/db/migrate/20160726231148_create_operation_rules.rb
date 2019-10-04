class CreateOperationRules < ActiveRecord::Migration[5.0]
  def change
    create_table :operation_rules do |t|
      t.string :day_of_week_closed
      t.integer :open_hour
      t.integer :open_minute
      t.integer :close_hour
      t.integer :close_minute
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
