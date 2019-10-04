class ExamsController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin
  before_action :set_exam, only: [:edit, :update, :destroy]

  def index
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons_ids = Lesson.where(study_program_id: @study_programs_ids)
    # Get the exams for all study programs
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                          lessons.study_program_id, lessons.chapter_number, lessons.chapter_name")
                                   .joins(:lesson)
                                   .where(lesson_id: @lessons_ids)
                                   .order("lessons.study_program_id, lessons.chapter_number")
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @exams.size
  end

  def edit
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons = Lesson.select("id, study_program_id || ' ' || chapter_number || ' ' || chapter_name as l_name")
                            .where(study_program_id: @study_programs_ids)
  end

  def new
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons = Lesson.select("id, study_program_id || ' ' || chapter_number || ' ' || chapter_name as l_name")
                            .where(study_program_id: @study_programs_ids)
    @exam = Exam.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @exam = Exam.new(exam_params)
    # Upload the file first
    uploaded_io = params[:exam][:document_name]
    if !uploaded_io.nil?
      #sys_doc_name = User.new_token
      sys_doc_name = uploaded_io.original_filename
      #@document_path = Rails.root.join("public", "uploads", sys_doc_name)
      @document_path =  Rails.root.join("app/views", "study_sessions", sys_doc_name)
      @exam.document_path = @document_path
      #File.open(@exam.document_path, "wb") do |file|
      #  file.write(uploaded_io.read)
      #end
    end
    
    if @exam.save
      @study_programs_ids = current_school_user.school.study_programs.ids
      @lessons_ids = Lesson.where(study_program_id: @study_programs_ids)
      # Get the exams for all study programs
      @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                            lessons.study_program_id, lessons.chapter_number, lessons.chapter_name")
                            .joins(:lesson)
                            .where(lesson_id: @lessons_ids)
      # Use @head and @tail to show table correctly
      @head = 0
      @tail = @exams.size
    else
      render 'new'
    end

    respond_to do |format|
      format.html { flash.now[:success] = "Exam created!" }
      format.js {}
    end
    # Hack:
    redirect_to exams_path
  end

  def update
    @old_document_path = @exam.document_path
    # Upload the file first
    uploaded_io = params[:exam][:document_name]
    if !uploaded_io.nil?
      #sys_doc_name = User.new_token
      sys_doc_name = uploaded_io.original_filename
      #@document_path = Rails.root.join("public", "uploads", sys_doc_name)
      @document_path = Rails.root.join("app/views", "study_sessions", sys_doc_name)
      # Why document_path is not `permitted` on edit/update???? Hack:
      @exam.document_path = @document_path
      #File.open(@document_path, "wb") do |file|
      #  file.write(uploaded_io.read)
      #end
      #if @old_document_path != @document_path
      #  File.delete(@old_document_path) if File.exists?(@old_document_path)
      #end
    end

    respond_to do |format|
      if @exam.update_attributes(exam_params)
        @study_programs_ids = current_school_user.school.study_programs.ids
        @lessons_ids = Lesson.where(study_program_id: @study_programs_ids)
        # Get the exams for all study programs
        @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                              lessons.study_program_id, lessons.chapter_number, lessons.chapter_name")
                              .joins(:lesson)
                              .where(lesson_id: @lessons_ids)
        # Use @head and @tail to show table correctly
        @head = 0
        @tail = @exams.size
        format.html { flash.now[:success] = "Exam updated!" }
        format.js {}
      else
        render redirect_to exams_path
      end
    end
    #Hack:
    redirect_to exams_path
  end

  def destroy
    @exam.destroy
    File.delete(@exam.document_path) if File.exists?(@exam.document_path)
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons_ids = Lesson.where(study_program_id: @study_programs_ids)
    # Get the exams for all study programs
    @exams = Exam.select("exams.id, exams.document_path, exams.lesson_id,
                          lessons.study_program_id, lessons.chapter_number, lessons.chapter_name")
                          .joins(:lesson)
                          .where(lesson_id: @lessons_ids)
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @exams.size
  end

    # Before filters
  
    # Check if school admin
    def school_admin
      @user = current_user
      redirect_to(root_url) unless school_admin?(@user)
    end
    
    def exam_params
      params.require(:exam).permit(:lesson_id)
    end
    
    def set_exam
      @exam = Exam.find(params[:id])
    end
end
