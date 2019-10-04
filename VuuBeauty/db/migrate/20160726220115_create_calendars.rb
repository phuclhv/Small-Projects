class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.integer :day
      t.string :day_of_week
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
