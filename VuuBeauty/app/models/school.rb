class School < ApplicationRecord
  has_many  :study_programs, dependent: :destroy
  has_many  :school_users
  has_many  :operation_rules
end
