class ProgramRequirement < ApplicationRecord
  belongs_to :study_program
  belongs_to :activity
end
