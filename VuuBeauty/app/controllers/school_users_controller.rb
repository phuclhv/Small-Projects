class SchoolUsersController < ApplicationController
  before_action :logged_in_user
  #before_action :school_admin

  def index
    @school_users = SchoolUser.select("school_users.*, users.*, program_enrollments.* ")
                                   .joins("JOIN users ON users.id = school_users.user_id")
                                   .joins("JOIN program_enrollments ON program_enrollments.school_user_id = school_users.id")
                                   .where(school_id: params[:id]).paginate(page: params[:page]).order("users.first_name, users.last_name")
    #@school_admin = current_school_user
  end

  def new
    @school_user = SchoolUser.new
  end

  def create
    @school_user = SchoolUser.new(school_user_params)
    @school_user.school_user_type_id = SchoolUserType.find_by(description: "Student").id
    @school_user.race_id = Race.find_by(description: "Other").id
    @school_user.education_level_id = EducationLevel.find_by(description: "Other").id
    @school_user.user_id = current_user.id
    if @school_user.save
      flash[:success] = "You're enrolled at " + @school_user.school.name + "."
      log_in_school_user(@school_user.user)
      redirect_to enroll_program_path
    else
      render 'new'
    end
  end

  def show
    @study_programs = StudyProgram.where("school_id = ? and id != ?", current_user.school_users.first.school_id, 4)
  end

  private
  
    def school_user_params
      params.require(:school_user).permit(:dob, :gender, :school_id)
    end
end
