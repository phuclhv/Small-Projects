class AddCalendarIdToTimecards < ActiveRecord::Migration[5.0]
  def change
    add_reference :timecards, :calendar, foreign_key: true
  end
end
