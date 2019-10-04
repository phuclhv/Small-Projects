class QuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons_ids = Lesson.where(study_program_id: @study_programs_ids).ids
    # Get the exams for all study programs
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                          lessons.study_program_id || ': ' || lessons.chapter_number || ': ' || lessons.chapter_name as l_name")
                                   .joins(:lesson)
                                   .where(lesson_id: @lessons_ids)
    @questions = Question.where(exam_id: @exams.pluck(:id)).order(:question_name)
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @questions.size
  end

  def new
    @study_programs_ids = StudyProgram.all.where(school_id: current_school_user.school_id).ids
    @lessons_ids = Lesson.select("id, study_program_id || ' ' || chapter_number || ' ' || chapter_name as l_name")
                                .where(study_program_id: @study_programs_ids).ids
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id, exams.id || ': ' ||
                          lessons.study_program_id || ': ' || lessons.chapter_number || ': ' || lessons.chapter_name as l_name")
                                   .joins(:lesson)
                                   .where(lesson_id: @lessons_ids).order("exams.lesson_id DESC")
    @question = Question.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @questions_count = params[:questions_count].to_i
    @answer_keys = params[:answer_keys]
    answer_prefix = params[:question][:question_name]
    exam_id = params[:question][:exam_id]
    if @questions_count.nil? || @answer_keys.nil? then
      @question = Question.new(question_params)
      @question.save
    else
      @answer_keys_a = @answer_keys.split(//)
      if @questions_count == @answer_keys_a.count then
        @answer_keys_a.each_index do |idx|
          @question = Question.new
          @question.exam_id = exam_id
          @question.question_number = idx + 1
          @question.question_name = answer_prefix + @question.question_number.to_s
          @question.answer_key = @answer_keys_a[idx]
          @question.save
        end
      else
        # This doesn't work
        flash[:warning] = "Count does not match number of answer keys!"
        render 'new'
      end
    end
    @questions = Question.where(exam_id: @question.exam_id).order("id DESC")
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @questions.size
    respond_to do |format|
      format.html { flash.now[:success] = "Question created!" }
      format.js {}
    end
  end

  def edit
    @study_programs_ids = StudyProgram.all.where(school_id: current_school_user.school_id).ids
    @lessons_ids = Lesson.select("id, study_program_id || ' ' || chapter_number || ' ' || chapter_name as l_name")
                                .where(study_program_id: @study_programs_ids).ids
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id, exams.id || ': ' ||
                          lessons.study_program_id || ': ' || lessons.chapter_number || ': ' || lessons.chapter_name as l_name")
                                   .joins(:lesson)
                                   .where(lesson_id: @lessons_ids)
  end
  
  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { flash[:success] = "Question updated!" }
        format.js {}
        @questions = Question.where(exam_id: @question.exam_id)
        # Use @head and @tail to show table correctly
        @head = 0
        @tail = @questions.size
      else
        flash[:warning] = "Failed to update question."
        redirect_to questions_path
      end
    end
  end

  def destroy
    @question.destroy
    @questions = Question.where(exam_id: @question.exam_id)
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @questions.size
  end


    # Before filters
  
    # Check if school admin
    def school_admin
      @user = current_user
      redirect_to(root_url) unless school_admin?(@user)
    end
    
    def question_params
      params.require(:question).permit(:exam_id, :question_number, :question_name, :answer_key)
    end
    
    def set_question
      @question = Question.find(params[:id])
    end
end
