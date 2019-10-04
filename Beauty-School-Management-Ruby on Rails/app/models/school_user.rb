class SchoolUser < ApplicationRecord
  belongs_to  :school_user_type
  belongs_to  :race
  belongs_to  :education_level
  belongs_to  :user
  belongs_to  :school
  has_many    :timecards, dependent: :destroy
  has_many    :program_enrollments
  has_many    :student_lessons  
  has_many    :student_hour_summaries
  GENDER_TYPES = ["N/A", "Male", "Female"]
  validates   :user_id,   presence: true
end
