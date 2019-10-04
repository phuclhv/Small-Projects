class ProgramEnrollmentsController < ApplicationController
  before_action :logged_in_user

  def new
    @program_enrollment = ProgramEnrollment.new
    @school = School.find(current_school_user.school_id)
  end

  def create
    if ProgramEnrollment.where(school_user_id: current_school_user.id, enrollment_status_id: 1).exists?
      flash[:error] = "You are already enrolled in a program."
      redirect_to root_path
    else
      @school = School.find(current_school_user.school_id)
      @program_enrollment = ProgramEnrollment.new(program_enrollment_params)
      study_program = StudyProgram.find(@program_enrollment.study_program_id)
      @program_enrollment.tuition_balance = study_program.tuition
      @program_enrollment.school_user_id = params[:school_user_id]
      @program_enrollment.enrollment_date = Time.zone.now
      @program_enrollment.enrollment_status_id = ENROLLMENT_STATUSES[:ACTIVE]
      now = Time.zone.now
      if @program_enrollment.save
        @program_enrollment.study_program.program_requirements.each do |pr|
          @shs = StudentHourSummary.new(activity_id:            pr.activity_id,
                                        school_user_id:         @program_enrollment.school_user_id,
                                        month:                  now.month,
                                        year:                   now.year,
                                        monthly_total:          0,
                                        to_date_total:          0,
                                        remaining_required:     pr.hours,
                                        previous_to_date_total: 0)
          @shs.save
        end
        flash[:success] = "You're enrolled in the " + study_program.title + " program."
        redirect_to new_charge_path
      else
        render 'new'
      end
    end
  end

  private
  
    def program_enrollment_params
      params.require(:program_enrollment).permit(:online, :study_program_id, :enrollment_status_id, :contract_agreement)
    end

end
