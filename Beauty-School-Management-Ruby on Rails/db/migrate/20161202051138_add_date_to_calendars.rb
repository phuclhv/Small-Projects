class AddDateToCalendars < ActiveRecord::Migration[5.0]
  def change
    add_column :calendars, :date, :datetime
  end
end
