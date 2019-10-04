class StudentLessonsController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin
  before_action :set_student_lesson, only: [:edit, :update, :destroy]

  def index
    @students = SchoolUser.where(school_id: @current_school_user.school_id)
    @student_lessons = StudentLesson.where(school_user_id: @students.pluck(:id)).order(:taken_order)
    
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @student_lessons.size
  end
  
  def new
    # Get students, who are ACTIVE school_users that have enrolled in one of the programs.
    @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as name,
                                   program_enrollments.study_program_id")
                                   .joins(:user, :program_enrollments)
                                   .where(school_id: @current_school_user.school_id)
                                   .where("program_enrollments.enrollment_status_id = 1").order("users.first_name, users.last_name")
    @lessons = Lesson.joins(:study_program).where(study_program_id: @students.first.study_program_id)
    @student_lesson = StudentLesson.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def load_lesson
    # See https://kernelgarden.wordpress.com/2014/02/26/dynamic-select-boxes-in-rails-4/
    @school_user_id = params[:school_user_id]
    @student = SchoolUser.find(@school_user_id)
    @program_enrollment = @student.program_enrollments
    if @program_enrollment.exists?
      @lessons = @program_enrollment.first.study_program.lessons
    else
      @lessons = nil
    end

    @xmldoc = "<lessons_list>"
    if !@lessons.nil?
      @lessons.each do |lesson|
        @xmldoc = @xmldoc + " <lesson>"
        @xmldoc = @xmldoc + "   <id>" + lesson.id.to_s + "</id>"
        @xmldoc = @xmldoc + "   <lesson_name>" + lesson.lesson_name + "</lesson_name>"
        @xmldoc = @xmldoc + " </lesson>"
      end    
    end
    @xmldoc = @xmldoc + "</lessons_list>"

    render xml: @xmldoc
  end

  def create
    @student_lesson = StudentLesson.new(student_lesson_params)
    # Active student only
    @school_user_id = @student_lesson.school_user_id
    @study_program_id = ProgramEnrollment.where(school_user_id: @student_lesson.school_user_id, enrollment_status_id: 1).first.study_program_id
    @student_lessons = StudentLesson.select("lesson_id, taken_order").where(school_user_id: @school_user_id).order(:taken_order)
    if @student_lessons.size > 0
      @lesson_number = @student_lessons.last.taken_order
    else
      @lesson_number = 0
    end
    @lessons = Lesson.joins(:study_program).where(study_program_id: @study_program_id).where.not(id: @student_lessons.pluck(:lesson_id))
    ActiveRecord::Base.transaction do
      @lessons.each do |le|
        @lesson_number = @lesson_number + 1
        @student_lesson = StudentLesson.new(school_user_id: @school_user_id, lesson_id: le.id, completed: false, visible: true, enabled: true, taken_order: @lesson_number)
        @student_lesson.save
      end
    end # Transaction
    if @lesson_number > 0
      @students = SchoolUser.joins(:program_enrollments).where(school_id: @current_school_user.school_id, id: @school_user_id)
      @student_lessons = StudentLesson.where(school_user_id: @students.pluck(:id))
      # Use @head and @tail to show table correctly
      @head = 0
      @tail = @student_lessons.size

      respond_to do |format|
        format.html { flash[:success] = "Lesson assigned to student." }
        format.js
      end
    else
      render 'new'
    end
  end

  def edit
    # Get the correct student
    @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as name,
                                   program_enrollments.study_program_id")
                                   .joins(:user, :program_enrollments)
                                   .where(id: @student_lesson.school_user_id)
    @lessons = Lesson.joins(:study_program)
                     .where(study_program_id: ProgramEnrollment.find_by(school_user_id: @student_lesson.school_user_id).study_program_id)
  end

  def update
    if @student_lesson.update_attributes(student_lesson_params)
      @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as name,
                                   program_enrollments.study_program_id")
                                   .joins(:user, :program_enrollments)
                                   .where(id: @student_lesson.school_user_id)
      @student_lessons = StudentLesson.where(school_user_id: @students.pluck(:id))
      # Use @head and @tail to show table correctly
      @head = 0
      @tail = @student_lessons.size

      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:warning] = "Failed to update."
      redirect_to student_lessons_path
    end
  end

  def destroy
    @exam_result = ExamResult.find_by(student_lesson_id: @student_lesson.id)
    if !@exam_result.nil? then
      @exam_result.destroy
    end
    @student_lesson.destroy
    @students = SchoolUser.where(school_id: @current_school_user.school_id)
    @student_lessons = StudentLesson.where(school_user_id: @students.pluck(:id))
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @student_lessons.size
  end
  
  private
    # Before filters
  
    # Check if school admin
    def school_admin
      @current_user = current_user
      @current_school_user = current_school_user
      redirect_to(root_url) unless school_admin?(@current_user)
    end
    
    def student_lesson_params
      params.require(:student_lesson).permit(:school_user_id, :lesson_id, :completed,
                                             :visible, :enabled, :taken_order)
    end
    
  def set_student_lesson
    @student_lesson = StudentLesson.find(params[:id])
  end

end
