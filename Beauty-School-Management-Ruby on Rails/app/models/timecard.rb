class Timecard < ApplicationRecord
  belongs_to  :school_user
  belongs_to  :calendar
  default_scope -> { order(clock_in: :desc) }
  validates   :school_user_id,    presence: true
  validates   :clock_in,          presence: true
  
  def duration_in_minutes
    if clock_out.nil?
      0
    else
      (clock_out - clock_in)/60
    end
  end

  def duration_in_hours
    if clock_out.nil?
      0
    else
      ((clock_out - clock_in)/60)/60
    end
  end
end
