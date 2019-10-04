class StudentHourSummary < ApplicationRecord
  belongs_to :activity
  belongs_to :school_user
end
