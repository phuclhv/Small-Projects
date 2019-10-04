class AddSchoolUserToTimecards < ActiveRecord::Migration[5.0]
  def change
    add_reference :timecards, :school_user, foreign_key: true
  end
end
