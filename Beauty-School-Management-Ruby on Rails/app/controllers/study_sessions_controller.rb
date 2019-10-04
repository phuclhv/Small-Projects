class StudySessionsController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token, :only => :submit_Exam

  def new
    @student_lessons_ids = StudentLesson.where(school_user_id: current_school_user.id).pluck(:lesson_id)
    @lessons = Lesson.select("lessons.id, lessons.lesson_name, exams.id as exam_id, lessons.lesson_number")
                            .joins(:exams)
                            .where(id: @student_lessons_ids)
    @lessons_ids = @lessons.pluck(:id)
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                          lessons.study_program_id, lessons.chapter_number, lessons.chapter_name")
                                   .joins(:lesson)
                                   .where(lesson_id: @lessons_ids)
  end
  
  def create
    @lesson = Lesson.find(params[:id]) if Lesson.exists?(id: params[:id])
    @htmldoc = File.read(@lesson.document_path) if File.exists?(@lesson.document_path)
  end

  def load_exam
    @exam = Exam.find(params[:id])
    @htmlexam = File.read(@exam.document_path) if File.exists?(@exam.document_path)
  end
  
  def submit_Exam
    @questionAnswerObj = JSON.parse(params[:questionAnswerObj])
    @question_name = @questionAnswerObj.keys.first
    if !@question_name.nil? then
      @chapter_number = @question_name.split("_")[1]
    else
      return
    end
    @school_user_id = current_school_user.id
    @lesson_id = Lesson.joins(:student_lessons, :exams).where("student_lessons.school_user_id = ? and chapter_number = ?", @school_user_id, @chapter_number)
    @exam_id = Exam.find_by(lesson_id: @lesson_id).id
    @student_lesson_id = StudentLesson.find_by(lesson_id: @lesson_id, school_user_id: @school_user_id).id
    @questions = Question.where(exam_id: @exam_id)
    @answers = ''
    @score = 0
    right_answer_count = 0
    @questions.each do |q|
      answer = @questionAnswerObj[q.question_name]
      if q.answer_key == answer then
        q.your_answer = true
        right_answer_count = right_answer_count + 1
      else
        q.your_answer = false
      end
      if answer.nil? then
        answer = "x"
      end
      @answers = @answers + answer
    end
    # Record the exam result
    @score = ((right_answer_count.to_f/@questions.size)*100).round
    ExamResult.create!(exam_id: @exam_id, score: @score, answers: @answers, student_lesson_id: @student_lesson_id)

    render json: @questions
  end
end