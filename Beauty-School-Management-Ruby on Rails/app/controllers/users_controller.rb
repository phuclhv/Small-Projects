class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @study_programs = StudyProgram.where("school_id = ? and id != ?", 1, 4)
    redirect_to root_url and return unless @user.activated?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    #puts "Debugging ...."
    #puts params[:id]
    #puts "end debugging"
    @student = SchoolUser.where(user_id: params[:id])
    if @student.size == 0 then
      return
    else
      @school_user = @student.first
    end
    @user_id = @school_user.user_id
    @school_user_id = @school_user.id
    # Remove all the related records
    ActiveRecord::Base.transaction do
      # Address
      Address.where(user_id: @user_id).delete_all unless Address.where(user_id: @user_id).size == 0
      # Payment
      Payment.where(school_user_id: @school_user_id).delete_all unless Payment.where(school_user_id: @school_user_id).size == 0
      # StudentLesson and ExamResult
      @student_lessons = StudentLesson.where(school_user_id: @school_user_id)
      if @student_lessons.size > 0
        ExamResult.where(student_lesson_id: @student_lessons.pluck(:id)).delete_all
        StudentLesson.where(school_user_id: @school_user_id).delete_all
      end
      # Student hours
      StudentHour.where(school_user_id: @school_user_id).delete_all
      Timecard.where(school_user_id: @school_user_id).delete_all
      StudentHourSummary.where(school_user_id: @school_user_id).delete_all
      # Enrollment
      ProgramEnrollment.where(school_user_id: @school_user_id).delete_all
      SchoolUser.where(id: @school_user_id).delete_all
      User.where(id: @user_id).delete_all
    end # Transaction
    flash[:success] = "Student deleted!"
    redirect_to school_users_path(id: current_school_user.school_id)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                                                    :password_confirmation)
    end
    
    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
