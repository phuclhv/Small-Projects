class ProgramEnrollment < ApplicationRecord
  belongs_to :school_user
  belongs_to :study_program
  validates :contract_agreement, acceptance: true
end
