class Lesson < ApplicationRecord
  belongs_to  :study_program
  has_many    :student_lessons
  has_many    :exams
end
