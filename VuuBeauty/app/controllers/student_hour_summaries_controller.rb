class StudentHourSummariesController < ApplicationController
  before_action :school_admin
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :index]
  
  def index
    @school_user_ids = SchoolUser.where(school_id: current_school_user.school_id)
    @student_hour_summaries = StudentHourSummary.where(school_user_id: @school_user_ids).order(:school_user_id, :year, :month, :activity_id).paginate(page: params[:page])
  end

  def new
    @student_hour_summary = StudentHourSummary.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @shs = StudentHourSummary.new(student_hour_summary_params)
    respond_to do |format|
      if @shs.save
        format.html { flash[:success] = "Student Hour Summary created!" }
        format.js {}
      else
        render 'new'
      end
    end
    @student_hour_summaries = StudentHourSummary.where(school_user_id: @shs.school_user_id, month: @shs.month, year: @shs.year)
                                                .order(:school_user_id, :year, :month, :activity_id)
  end

  def edit
    @student_hour_summary = StudentHourSummary.find(params[:id])
  end

  def update
    @student_hour_summary = StudentHourSummary.find(params[:id])
    respond_to do |format|
      if @student_hour_summary.update_attributes(student_hour_summary_params)
        format.html { flash[:success] = "Student Hour Summary updated!" }
        format.js {}
        @student_hour_summaries = StudentHourSummary.where(school_user_id: @student_hour_summary.school_user_id,
                                                           month: @student_hour_summary.month, year: @student_hour_summary.year)
                                                    .order(:school_user_id, :year, :month, :activity_id)
      else
        redirect_to student_hour_summaries_path
      end
    end
  end

  def destroy
    @student_hour_summary = StudentHourSummary.find(params[:id])
    @student_hour_summary.destroy
    @student_hour_summaries = StudentHourSummary.where(school_user_id: @student_hour_summary.school_user_id,
                                                       month: @student_hour_summary.month, year: @student_hour_summary.year)
                                                .order(:school_user_id, :year, :month, :activity_id)
  end

  private
    def student_hour_summary_params
      params.require(:student_hour_summary).permit(:school_user_id, :activity_id, :month, :year, :monthly_total,
                                                   :to_date_total, :remaining_required, :previous_to_date_total)
    end
end
