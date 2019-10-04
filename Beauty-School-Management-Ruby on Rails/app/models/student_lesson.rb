class StudentLesson < ApplicationRecord
  belongs_to  :school_user
  belongs_to  :lesson
  has_many    :exam_results
  default_scope -> { order(school_user_id: :asc, taken_order: :asc, lesson_id: :asc) }
end
