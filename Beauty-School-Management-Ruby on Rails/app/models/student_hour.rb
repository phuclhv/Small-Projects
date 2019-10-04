class StudentHour < ApplicationRecord
  belongs_to :calendar
  belongs_to :activity
  belongs_to :timecard
  belongs_to :school_user
end
