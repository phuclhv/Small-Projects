class ExamResultsController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  
  def index
    @exam_results = ExamResult.joins(:student_lesson)
                              .where("student_lessons.school_user_id = ?", current_school_user.id)
                              .order(:exam_id)
  end
end
