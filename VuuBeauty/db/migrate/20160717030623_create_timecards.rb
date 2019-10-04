class CreateTimecards < ActiveRecord::Migration[5.0]
  def change
    create_table :timecards do |t|
      t.datetime :clock_in
      t.datetime :clock_out
      t.boolean :processed, default: false

      t.timestamps
    end
    change_column_null  :timecards, :clock_in, false
  end
end