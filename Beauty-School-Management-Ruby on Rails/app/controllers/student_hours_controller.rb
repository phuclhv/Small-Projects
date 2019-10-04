class StudentHoursController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin

  def index
    @students = SchoolUser.select("school_users.*, users.first_name || ' ' || users.last_name as full_name")
                                  .joins(:user)
                                  .where(school_id: current_school_user.school_id)
                                  .order("users.first_name, users.last_name")
    first_day_last_month = Date.today.at_beginning_of_month.last_month
    @student_hours_summaries = StudentHourSummary.select("school_user_id, year, month, sum(monthly_total) as monthly_total")
                                                         .where(school_user_id: @students.ids,
                                                                year: first_day_last_month.year)
                                                         .where("month <= ?", first_day_last_month.month)
                                                         .group("school_user_id, year, month")
                                                         .order("school_user_id, year, month")
    @calendars = Calendar.select("id, month || '-' || year as month_year")
                                  .where("year > ? and year <= ? and day = 1", 2.years.ago.year, 0.year.ago.year)
    now = Time.zone.now.at_beginning_of_month.last_month
    @report_month_calendar_id = Calendar.find_by(day: now.day, month: now.month, year: now.year).id
  end
  
  def create
    school_user_id = params[:school_user_id]
    calendar_id = params[:calendar_id]
    @school_user = SchoolUser.find(school_user_id)
    @user = User.select("users.*, first_name || ' ' || last_name as full_name").find(@school_user.user_id)
    @school = School.find(@school_user.school_id)
    @study_program = StudyProgram.select("study_programs.id, study_programs.title")
                                        .joins(:program_enrollments)
                                        .where("program_enrollments.school_user_id = ?", school_user_id).first
    @program_requirements = ProgramRequirement.select("activities.id, activities.name, program_requirements.hours")
                                                      .joins(:activity)
                                                      .where("program_requirements.study_program_id = ?",
                                                              @study_program.id)
                                                      .order(:id)
    # Get daily hours rows
    @calendar = Calendar.find(calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    @student_hours = StudentHour.select("student_hours.*, calendars.month || '-' || calendars.day || '-' || calendars.year as tc_date")
                                        .joins(:calendar)
                                        .where(school_user_id: school_user_id)
                                        .where(calendar_id: @calendar_ids)
                                        .order(:calendar_id, :activity_id)
    if @student_hours.size == 0 then
      flash[:danger] = "Student hours are not available for the selected month and year."
      redirect_to student_hours_path
    else
      @daily_hours_h = Hash.new
      @calendarID = 0
      @student_hours.each do |sh|
        if sh.calendar_id != @calendarID then
          @daily_hours_a = Array.new
          @daily_hours_h[sh.tc_date] = @daily_hours_a
          @calendarID = sh.calendar_id
        end
        if sh.daily_hour.nil? then
          sh.daily_hour = 0
        end
        @daily_hours_a << sh.daily_hour.round(2)
      end
      # Get monthly total hours row
      array_size = @daily_hours_a.size
      @monthly_total_a = Array.new
      for i in 0..(array_size - 1)
        activity_total = 0
        @daily_hours_h.each do |tcd, hours_array|
          if (!hours_array.nil? && !hours_array[i].nil?) then
            activity_total = activity_total + hours_array[i]
          end
        end
        @monthly_total_a << activity_total
      end
      # Get previous months total row
      @student_hour_summaries = StudentHourSummary.where(school_user_id: school_user_id, month: @calendar.month, year: @calendar.year).order(:activity_id)
    end
  end
end
