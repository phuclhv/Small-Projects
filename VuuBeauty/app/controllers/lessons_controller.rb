class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def index
    @study_programs_ids = current_school_user.school.study_programs.ids
    @lessons = Lesson.where(study_program_id: @study_programs_ids).order(:study_program_id, :chapter_number)
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @lessons.size
  end

  def show
  end

  def new
    @lesson = Lesson.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)
    # Upload the file first
    uploaded_io = params[:lesson][:document_name]
    if !uploaded_io.nil?
      #sys_doc_name = User.new_token
      sys_doc_name = uploaded_io.original_filename
      #@document_path = Rails.root.join("public", "uploads", sys_doc_name)
      @document_path = Rails.root.join("app/views", "study_sessions", sys_doc_name)
      @lesson.document_name = uploaded_io.original_filename
      @lesson.document_path = @document_path
      @lesson.sys_doc_name = sys_doc_name
      #File.open(@lesson.document_path, "wb") do |file|
      #  file.write(uploaded_io.read)
      #end
    end
    
    if @lesson.save
      @study_programs = current_school_user.school.study_programs
      @lessons = Lesson.where(study_program_id: @study_programs.pluck(:id))
      # Use @head and @tail to show table correctly
      @head = 0
      @tail = @lessons.size
    else
      render 'new'
    end

    respond_to do |format|
      format.html { flash.now[:success] = "Lesson created!" }
      format.js {}
    end
    # Hack:
    redirect_to lessons_path
  end

  def update
    @old_document_path = @lesson.document_path
    # Upload the file first
    uploaded_io = params[:lesson][:document_name]
    if !uploaded_io.nil?
      params[:lesson][:document_name] = uploaded_io.original_filename
      sys_doc_name = uploaded_io.original_filename
      #sys_doc_name = User.new_token
      params[:lesson][:sys_doc_name] = sys_doc_name
      @document_path = Rails.root.join("app/views", "study_sessions", sys_doc_name)
      # Why document_path is not `permitted` on edit/update???? Hack:
      @lesson.document_path = @document_path
      #File.open(@document_path, "wb") do |file|
      #  file.write(uploaded_io.read)
      #end
      #if @old_document_path != @document_path
      #  File.delete(@old_document_path) if File.exists?(@old_document_path)
      #end
    end

    respond_to do |format|
      if @lesson.update_attributes(lesson_params)
        @study_programs = current_school_user.school.study_programs
        @lessons = Lesson.where(study_program_id: @study_programs.pluck(:id))
        # Use @head and @tail to show table correctly
        @head = 0
        @tail = @lessons.size
        format.html { flash.now[:success] = "Lesson updated!" }
        format.js {}
      else
        render redirect_to lessons_path
      end
    end
    #Hack:
    redirect_to lessons_path
  end

  def destroy
    @lesson.destroy
    File.delete(@lesson.document_path) if File.exists?(@lesson.document_path)
    @study_programs = current_school_user.school.study_programs
    @lessons = Lesson.where(study_program_id: @study_programs.pluck(:id))
    
    # Use @head and @tail to show table correctly
    @head = 0
    @tail = @lessons.size
  end
  
  private
  
    # Before filters
  
    # Check if school admin
    def school_admin
      @user = current_user
      redirect_to(root_url) unless school_admin?(@user)
    end
    
    def lesson_params
      params.require(:lesson).permit(:study_program_id, :chapter_number, :chapter_name, :lesson_number, :lesson_name,
                                     :book_name, :page_number, :document_path, :document_name, :sys_doc_name)
    end
    
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
end
