class StudyProgram < ApplicationRecord
  belongs_to  :school
  has_many    :program_requirements,  dependent: :destroy
  has_many    :program_enrollments,   dependent: :destroy
  has_many    :lessons,               dependent: :destroy
  validates   :school_id, presence: true

  def title_with_price
    "#{title} -- $#{tuition}"
  end
end
