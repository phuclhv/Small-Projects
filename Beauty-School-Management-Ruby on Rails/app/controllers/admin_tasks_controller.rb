class AdminTasksController < ApplicationController
  before_action :logged_in_user
  before_action :school_admin
  before_action :set_params

  ##############################################################################################
  #     Enroll student manually
  ##############################################################################################
  def new_student
    @user = User.new
    @school_user = SchoolUser.new
  end

  def create_student
    @school_user_type_id  = 1 # Student
    @enrollment_status_id = 1 # Active
    # Get the params
    @first_name             = params[:first_name]
    @last_name              = params[:last_name]
    @email                  = params[:email]
    @password               = params[:password]
    @password_confirmation  = params[:password_confirmation]
    @gender                 = params[:gender]
    @school_id              = params[:school_id]
    @study_program          = params[:study_program]
    @race_id                = params[:race_id]
    @education_level_id     = params[:education_level_id]
    @tuition                = params[:tuition]
    @enrollment_date        = ((params[:enrollment_date]).to_i).day.ago
    # Validate birthday
    @birth_day= /(\d{1,2}[-\/]\d{1,2}[-\/]\d{4})|(\d{4}[-\/]\d{1,2}[-\/]\d{1,2})/.match(params[:dob])
    if !@birth_day.nil? then
      begin
        @dob = Date.strptime(@birth_day[0], "%m/%d/%Y")
      rescue ArgumentError
        @dob = Date.strptime(@birth_day[0], "%m-%d-%Y")
      end
    else
      flash[:error] = "Invalid DOB"
    end
    # Validate the SSN
    @social_security_number = /(\d{3})[^\d]?(\d{2})[^\d]?(\d{4})/.match(params[:ssn])
    if !@social_security_number.nil? then
      @ssn = @social_security_number[1] + '-' + @social_security_number[2]+ '-' + @social_security_number[3]
    end
    # Validate study program
    @study_program_id = StudyProgram.find_by(school_id: @school_id, title: @study_program).id
    @contract_agreement = (params[:contract_agreement] == "true")
    @assign_lessons = (params[:assign_lessons] == "true")
    # Get busy
    ActiveRecord::Base.transaction do
      @user = User.new(first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation, activated: true)
      if @user.save
        @school_user = SchoolUser.new(dob: @dob, gender: @gender, school_id: @school_id, school_user_type_id: @school_user_type_id,
                                      race_id: @race_id, education_level_id: @education_level_id, user_id: @user.id)
        if @school_user.save then
          @program_enrollment = ProgramEnrollment.new(online: true, study_program_id: @study_program_id, enrollment_status_id: @enrollment_status_id,
                                                      contract_agreement: @contract_agreement, tuition_balance: @tuition,
                                                      enrollment_date: @enrollment_date, school_user_id: @school_user.id)
          if @program_enrollment.save then
            @program_enrollment.study_program.program_requirements.each do |pr|
              @shs = StudentHourSummary.new(activity_id:            pr.activity_id,
                                            school_user_id:         @program_enrollment.school_user_id,
                                            month:                  @enrollment_date.month,
                                            year:                   @enrollment_date.year,
                                            monthly_total:          0,
                                            to_date_total:          0,
                                            remaining_required:     pr.hours,
                                            previous_to_date_total: 0)
              @shs.save
            end
          end
        end
        # Assign lessons
        if @assign_lessons
          # Active student only
          @school_user_id = @school_user.id
          @study_program_id = ProgramEnrollment.where(school_user_id: @school_user_id, enrollment_status_id: 1).first.study_program_id
          @student_lessons = StudentLesson.select("lesson_id, taken_order").where(school_user_id: @school_user_id).order(:taken_order)
          if @student_lessons.size > 0
            @lesson_number = @student_lessons.last.taken_order
          else
            @lesson_number = 0
          end
          @lessons = Lesson.joins(:study_program).where(study_program_id: @study_program_id).where.not(id: @student_lessons.pluck(:lesson_id))
          @lessons.each do |le|
            @lesson_number = @lesson_number + 1
            @student_lesson = StudentLesson.new(school_user_id: @school_user_id, lesson_id: le.id, completed: false, visible: true, enabled: true, taken_order: @lesson_number)
            @student_lesson.save
          end
        end # assign lessons
        flash[:success] = "Student enrolled successfully!"
        redirect_to school_users_path
      else
        render 'new_student'
      end # user.save
    end # transaction
  end
  
  def index_student_study_program
    @study_programs = StudyProgram.select("id, id || ':  ' || title as title")
                                  .where("school_id = ? and id != ?", current_school_user.school_id, 4)
  end
  
  def get_enrollment_info
    @studentObj = JSON.parse(params[:studentObj])

    # Get the student_id, i.e. school_user_id, from the view
    @school_user_id = @studentObj["0"]
    #study_program_id = @studentHoursObj["1"]
    @student = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as full_name, program_enrollments.study_program_id")
                                  .joins(:user)
                                  .joins(:program_enrollments)
                                  .where("school_users.id = ?", @school_user_id)
    render json: @student
  end
  
  def update_study_program
    @studentObj = JSON.parse(params[:studentObj])
    @school_user_id = @studentObj["0"]
    @new_study_program_id = @studentObj["1"]
    # Get the enrollment date
    @program_enrollment = ProgramEnrollment.find_by(school_user_id: @school_user_id, enrollment_status_id: 1)
    if @program_enrollment.nil?
      flash[:error] = "Student's enrollment status is not active."
      return
    else
     @enrollment_date = @program_enrollment.enrollment_date
    end
    @new_study_program = StudyProgram.find(@new_study_program_id)
    # Remove student hour summary, update timecards, and register the student in the new study program
    ActiveRecord::Base.transaction do
      @student_hour_summaries = StudentHourSummary.where("school_user_id = ? AND (year > ? OR (year = ? AND month >= ?))",
                                                        @school_user_id, @enrollment_date.year, @enrollment_date.year, @enrollment_date.month)
      @timecards = Timecard.where("school_user_id = ? AND processed = ? AND created_at >= ?", @school_user_id, true, @enrollment_date)
      @student_hours = StudentHour.where(timecard_id: @timecards.ids, school_user_id: @school_user_id)
      if @student_hours.size > 0
        @student_hours.delete_all
      end
      @student_hour_summaries.delete_all if !@student_hour_summaries.nil?
      @timecards.update_all(processed: false) if !@timecards.nil?
      @program_enrollment.update_columns(study_program_id: @new_study_program_id, tuition_balance: @new_study_program.tuition)
      @program_enrollment.save
      @program_enrollment.study_program.program_requirements.each do |pr|
        @shs = StudentHourSummary.new(activity_id:            pr.activity_id,
                                      school_user_id:         @program_enrollment.school_user_id,
                                      month:                  @enrollment_date.month,
                                      year:                   @enrollment_date.year,
                                      monthly_total:          0,
                                      to_date_total:          0,
                                      remaining_required:     pr.hours,
                                      previous_to_date_total: 0)
        @shs.save
      end
    end # transaction
    flash[:success] = "Student's study program is successfully changed!"
    redirect_to controller: "school_users", action: "index", id: current_school_user.id
  end

  ##############################################################################################
  #     Activate account manually
  ##############################################################################################
  def index_user
    @users = User.where(activated: false)
    @users_for_password_reset = User.all
  end

  def activate_user
    @user = User.find(params[:user_id])
    @user.activated = true
    if @user.save then
      flash[:success] = "User activated and ready for enrollment"
    else
      flash[:error] = "Failed to activate user"
    end
    redirect_to admin_tasks_user_index_path
  end

##############################################################################################
  #     Activate account manually
  ##############################################################################################
  def reset_password
    @user = User.find(params[:user_id])
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @user.password = @password
    @user.password_confirmation = @password_confirmation
    @user.reset_digest = nil
    if params[:password].empty?
      flash[:error] = "Password can not be empty"
    elsif @user.save
      flash[:success] = "Password has been reset for " + @user.full_name
    end
    redirect_to admin_tasks_user_index_path
  end

  ##############################################################################################
  #     Adjust tuition balance manually
  ##############################################################################################
  def index_student
    @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name ||
                                  ': ' || users.email ||
                                  ': ' || program_enrollments.tuition_balance as tuition_balance")
                                 .joins(:user, :program_enrollments)
                                 .where(school_id: current_school_user.school_id)
  end

  def adjust_tuition
    @school_user_id = params[:school_user_id]
    @tuition_balance = params[:tuition_balance]
    @program_enrollment = ProgramEnrollment.find_by(school_user_id: @school_user_id)
    @program_enrollment.tuition_balance = @tuition_balance

    if @program_enrollment.save then
      flash[:success] = "Tuition balance updated"
    else
      flash[:error] = "Failed to adjust tuition balance"
    end
    redirect_to admin_tasks_student_index_path
  end
  
  ##############################################################################################
  #     Payment
  ##############################################################################################
  
  def new_payment
    @payment = Payment.new
  end

  def create_payment
    amount = params[:amount]
    school_user_id = params[:school_user_id]
    payment_type_id = params[:payment_type_id]
    payment_date = params[:payment_date]
    @payment = Payment.new(amount: amount, school_user_id: school_user_id, payment_type_id: payment_type_id, payment_date: payment_date)
    if @payment.save
      @program_enrollment = ProgramEnrollment.find_by(school_user_id: school_user_id)
      @tuition_balance = @program_enrollment.tuition_balance - @payment.amount
      @program_enrollment.update_columns(tuition_balance: @tuition_balance)
      flash[:success] = "Payment processed."
      redirect_to admin_tasks_payment_receipt_path(id: @payment.id)
    else
      render 'new_payment'
    end
  end

  def show_payment_receipt
    @school = School.find(current_school_user.school_id)
    @payment = Payment.select("payments.id, payments.amount, payments.created_at, payment_types.description, payments.school_user_id")
                              .joins(:payment_type).where("payments.id = ?", params[:id]).first
    @user = User.joins(:school_users).where("school_users.id = ?", @payment.school_user_id).first
  end

  def index_payment_history
    #@students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as full_name ").joins(:user).where("school_id = ? ", current_school_user.school_id)
  end
  
  # Ajax call to list all of a student's payments
  def get_payments
    school_user_id = params[:school_user_id]
    @payments = Payment.select("payments.id, payments.amount, payments.created_at, payment_types.description")
                            .joins(:payment_type).where("payments.school_user_id = ?", school_user_id).to_json
    render json: @payments
  end

  ##############################################################################################
  #     Timecard
  ##############################################################################################
  def new_timecard
  end
  
  def index_timecard
    @calendars = Calendar.select("id, month || '-' || year as month_year")
                                .where("year > ? and year <= ? and day = 1", 2.years.ago.year, 0.year.ago.year)
    now = Time.zone.now.at_beginning_of_month.last_month
    @report_month_calendar_id = Calendar.find_by(day: now.day, month: now.month, year: now.year).id
  end

  def get_students_for_timecards
    @studentHoursObj = JSON.parse(params[:studentHoursObj])

    # Get the calendar_id and remove it from the hash.  The value is hard-coded as -1 from the view
    calendar_id = @studentHoursObj["0"]
    study_program_id = @studentHoursObj["1"]
    @calendar = Calendar.find(calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as full_name, 0 as duration_in_hours")
                                  .joins(:user)
                                  .joins(:program_enrollments)
                                  .where("program_enrollments.study_program_id = ? and school_id = ? and program_enrollments.enrollment_date <= ?",
                                          study_program_id, current_school_user.school_id, @calendar.date.end_of_month)
                                  .order("users.first_name, users.last_name")
    @students.each do |student|
      @timecards = Timecard.all.where(school_user_id: student.id, calendar_id: @calendar_ids)
      hour_total = 0
      @timecards.each do |tc|
        hour_total = hour_total + tc.duration_in_hours
      end
      student.duration_in_hours = hour_total.round
    end
    render json: @students.to_json
  end

  def get_timecards
    # Init some variables:
    @studentHoursObj = JSON.parse(params[:studentHoursObj])

    # Get the calendar_id and remove it from the hash.  The value is hard-coded as -1 from the view
    calendar_id = @studentHoursObj["0"]
    @calendar = Calendar.find(calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    school_user_id = @studentHoursObj["2"]
    @timecards = Timecard.select("timecards.*, 0 as duration_in_hours").where(school_user_id: school_user_id, calendar_id: @calendar_ids)
    render json: @timecards.to_json
  end

  def clock_out_students
    @school_id = current_school_user.school_id
    @timecards = Timecard.all.where(school_user_id: SchoolUser.where(school_id: @school_id).ids,
                                    clock_out: nil,
                                    clock_in: 180.day.ago..1.day.ago)
    @timecards.each do |tc|
      tc.clock_out = tc.clock_in.at_end_of_day
      tc.save
    end
    flash[:success] = "Student timecards updated"
    redirect_to admin_tasks_timecard_index_path
  end
  
  def delete_timecards
    count = 0
    @studentTimecardsObj = JSON.parse(params[:studentTimecardsObj])
    @studentTimecardsObj.each do |id, checked|
      if checked then
        @timecard = Timecard.find(id)
        @timecard.destroy
        count = count + 1
      end
    end
    flash[:success] = count.to_s + " student " + "timecard".pluralize(count) + " deleted"
    redirect_to admin_tasks_timecard_index_path
  end
  
  def adjust_student_hours
    # Init some variables:
    @studentHoursObj = JSON.parse(params[:studentHoursObj])

    # Get the calendar_id and remove it from the hash.  The value is hard-coded as -1 from the view
    calendar_id = @studentHoursObj["0"]
    @studentHoursObj.except!("0")
    @calendar = Calendar.find(calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    processing_month = @calendar.month
    processing_year  = @calendar.year
    day_of_week_closed = OperationRule.find_by(school_id: current_school_user.school_id).day_of_week_closed

    # Get busy:
    @studentHoursObj.each do |student_id, desired_total|
      # Adjust hours:
      #   a)  allocate to empty days first
      #   b)  any remaining hours from a), extend timecards

      # Count the hours in the current timecards:
      @timecards = Timecard.all.where(school_user_id: student_id, calendar_id: @calendar_ids)
      hour_total = 0
      @timecards.each do |tc|
        hour_total = hour_total + tc.duration_in_hours
      end
      desired_hour_total = desired_total.to_f
      if (desired_hour_total > 0) && (hour_total < desired_hour_total) then      
        enrollment_date = ProgramEnrollment.find_by(school_user_id: student_id).enrollment_date
        @calendar_days = Calendar.all.where(year: processing_year, month: processing_month)
                                     .where.not(day_of_week: day_of_week_closed)
                                     .where.not(id: Timecard.all.where(school_user_id: student_id, processed: false).pluck(:calendar_id))
                                     .where("date >= ?", enrollment_date)
        #   a)  allocate to empty days first
        # debugger
        @calendar_days.each do |cd|
          case
            when desired_hour_total > 8
              random_daily_hour = rand(6..8)
            when desired_hour_total > 7
              random_daily_hour = rand(5..7)
            when desired_hour_total > 6
              random_daily_hour = rand(4..6)
            when desired_hour_total > 5
              random_daily_hour = rand(3..5)
            when desired_hour_total > 4
              random_daily_hour = rand(2..4)
            else
              random_daily_hour = desired_hour_total
          end # case
          random_minute = rand(30..59)
          random_second = rand(1..59)
          clock_in = Time.new(cd.year, cd.month, cd.day, 17, random_minute, random_second)
          clock_out = clock_in + random_daily_hour.hours
          @timecard = Timecard.new(clock_in: clock_in, clock_out: clock_out, calendar_id: cd.id, school_user_id: student_id)
          if @timecard.save
            desired_hour_total = desired_hour_total - random_daily_hour
          end
          break if desired_hour_total <= 0
        end # each
        #   b)  any remaining hours from a), extend timecards
        while desired_hour_total > 1 do
          exit_check_hour_total = desired_hour_total
          @timecards = Timecard.all.where(school_user_id: student_id, calendar_id: @calendar_ids)
          @timecards.each do |tc|
            closing_time = Time.new(tc.clock_in.year, tc.clock_in.month, tc.clock_in.day, 17, 30, 0) + 7.hours + rand(1..60).minutes
            if (tc.duration_in_hours <= 7) && (tc.clock_out + 1.hours <= closing_time) then
              tc.clock_out = tc.clock_out + 1.hours
              if tc.save then
                desired_hour_total = desired_hour_total - 1
              end
            end
            break if desired_hour_total <= 0
          end # each
          if exit_check_hour_total == desired_hour_total
            desired_hour_total = 0 # All available days are already allocated so exit...
          end
        end # while
      end # if
    end # each
    flash[:success] = "Timecards updated"
    redirect_to admin_tasks_timecard_index_path
  end

  def process_student_hours
    # Init some variables:
    @studentHoursObj = JSON.parse(params[:studentHoursObj])

    # Get the calendar_id and remove it from the hash.  The value is hard-coded as -1 from the view
    @calendar_id = @studentHoursObj["-1"]
    @studentHoursObj.except!("-1")
    # Get the student ID to avoid duplicates
    @school_user_id = @studentHoursObj["-2"]
    @studentHoursObj.except!("-2")
    if !@studentHoursObj.key?(@school_user_id) then
      @studentHoursObj[@school_user_id] = 0
    end
    @calendar_id = @calendar_id.to_i
    @school_user_id = @school_user_id.to_i
    @calendar = Calendar.find(@calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    processing_month = @calendar.month
    processing_year  = @calendar.year
    number_of_activities = 0
    # Now process the hours for the students
    @studentHoursObj.each_key do |student_id|
      ActiveRecord::Base.transaction do
        @student_id = student_id.to_i
        @student_hours_summaries = StudentHourSummary.where(school_user_id: @student_id, year: processing_year, month: processing_month).order(remaining_required: :desc)
        if @student_hours_summaries.size == 0 then
          last_shs = StudentHourSummary.where(school_user_id: @student_id).order(:id).last
          @student_hours_summaries = StudentHourSummary.where(school_user_id: @student_id, month: last_shs.month, year: last_shs.year).order(:activity_id)
          # Duplicate for the reporting month
          @student_hours_summaries.each do |shs|
            @new_shs = shs.dup
            @new_shs.month = processing_month
            @new_shs.year  = processing_year
            @new_shs.monthly_total = 0
            @new_shs.previous_to_date_total = @new_shs.to_date_total
            @new_shs.save
          end
          @student_hours_summaries = StudentHourSummary.where(school_user_id: @student_id, year: processing_year, month: processing_month)
        end
        number_of_activities = @student_hours_summaries.size
        @timecards = Timecard.where(school_user_id: @student_id, calendar_id: @calendar_ids, processed: false)
        @timecards.each do |tc|
          daily_hour = tc.duration_in_hours
          activity_count_flag = 0
          activity_hour = 0
          @student_hours_summaries.each do |shs|
            # Start counting the number of activities
            activity_count_flag = activity_count_flag + 1
            # Get the remaining required hours for each activity
            remaining_required = shs.remaining_required
            if (remaining_required > daily_hour) && (daily_hour > 0) then
              if (daily_hour >= 4.00) then
                activity_hour = 4.00
                daily_hour    = daily_hour - activity_hour
              elsif (daily_hour >= 3.00) then
                activity_hour = 3.00
                daily_hour    = daily_hour - activity_hour
              elsif (daily_hour >= 2.00) then
                activity_hour = 2.00
                daily_hour    = daily_hour - activity_hour
              else
                activity_hour = daily_hour
                daily_hour    = 0
              end # if
            elsif (remaining_required <= daily_hour) && (daily_hour > 0) then
              if (remaining_required >= 3.00) then
                activity_hour = 3.00
                daily_hour    = daily_hour - activity_hour
              elsif (remaining_required >= 2.00) then
                activity_hour = 2.00
                daily_hour    = daily_hour - activity_hour
              elsif remaining_required > 0 then
                activity_hour = remaining_required
                daily_hour = daily_hour - activity_hour
                if daily_hour > 1 then
                  activity_hour = activity_hour + 0.50
                  daily_hour    = daily_hour - 0.50
                end
              end # if
            else
              activity_hour = 0
            end # if
            # Special case: too many hours to distribute to the only 1 remaining activity
            if (number_of_activities == activity_count_flag) && (daily_hour > 0) then
              activity_hour = activity_hour + daily_hour
            end
            # We might have more than 1 timecard per day, so make sure to GROUP BY on the monthly report!
            @sh = StudentHour.find_by(calendar_id: tc.calendar_id, activity_id: shs.activity_id, school_user_id: tc.school_user_id)
            if @sh.nil?
              StudentHour.create!(daily_hour: activity_hour, processed: true, calendar_id: tc.calendar_id,
                                  activity_id: shs.activity_id, timecard_id: tc.id, school_user_id: tc.school_user_id)
            else
              if activity_hour > 0 then
                @sh.daily_hour = @sh.daily_hour + activity_hour
                @sh.save
              end
            end
            if shs.monthly_total.nil? then
              shs.monthly_total = 0
            end
            shs.monthly_total = shs.monthly_total + activity_hour
            if shs.to_date_total.nil? then
              shs.to_date_total = 0
            end
            shs.to_date_total = shs.to_date_total + activity_hour
            if (remaining_required - activity_hour) < 0 then
              shs.remaining_required = 0
            else
              shs.remaining_required = remaining_required - activity_hour
            end
            shs.save
            activity_hour = 0
          end # each student_hours_summaries
          tc.processed = true
          tc.save
        end # each timecards
      end # Transaction
    end # each studentHoursObj
    flash[:success] = "Student hours processed"
    redirect_to admin_tasks_show_monthly_student_report_path
  end

  def show_monthly_student_report
    @students = SchoolUser.where(school_id: current_school_user.school_id)
    #first_day_last_month = Date.today.at_beginning_of_month.last_month
    # Need to add student's full_name to display below:
    @student_hour_summaries = SchoolUser.select("student_hour_summaries.school_user_id, users.first_name, users.last_name,
                                                 student_hour_summaries.month, student_hour_summaries.year,
                                                 sum(student_hour_summaries.monthly_total) as monthly_total")
                                                .joins(:user, :student_hour_summaries)
                                                .where(id: @students.ids)
                                                .group("school_user_id, first_name, last_name, month, year")
                                                .order("users.first_name, users.last_name, student_hour_summaries.year,
                                                        student_hour_summaries.month")
  end

  def rollback_student_hours
    # Init some variables:
    @studentHoursObj = JSON.parse(params[:studentHoursObj])

    # Get the calendar_id and remove it from the hash.  The value is hard-coded as -1 from the view
    @calendar_id = @studentHoursObj["-1"]
    @studentHoursObj.except!("-1")
    # Get the student ID to avoid duplicates
    @school_user_id = @studentHoursObj["-2"]
    @studentHoursObj.except!("-2")
    if !@studentHoursObj.key?(@school_user_id) then
      @studentHoursObj[@school_user_id] = 0
    end
    @calendar_id = @calendar_id.to_i
    @school_user_id = @school_user_id.to_i
    @calendar = Calendar.find(@calendar_id)
    @calendar_ids = Calendar.all.where(month: @calendar.month, year: @calendar.year).ids
    @calendar_first_day_of_month = Calendar.where(month: @calendar.month, year: @calendar.year).first
    @calendar_last_day_of_previous_month = @calendar_first_day_of_month.date - 1.day
    @user = User.joins(:school_users).where("school_users.id = ?", @school_user_id).first
    # Rollback the hours for the student
    ActiveRecord::Base.transaction do
      @timecards = Timecard.where(school_user_id: @school_user_id, calendar_id: @calendar_ids, processed: true)
      @student_hours = StudentHour.where(timecard_id: @timecards.ids, school_user_id: @school_user_id)
      if @student_hours.size > 0
        @student_hours.delete_all
      end
      @timecards.update_all(processed: false)
      @student_hour_summaries = StudentHourSummary.where(school_user_id: @school_user_id, month: @calendar.month, year: @calendar.year)
      if StudentHourSummary.where(month: @calendar_last_day_of_previous_month.month, year: @calendar_last_day_of_previous_month.year,
                                  school_user_id: @school_user_id).exists?
        @student_hour_summaries.delete_all
      else
        @student_hour_summaries.each do |shs|
          shs.monthly_total = 0
          shs.remaining_required = shs.remaining_required + shs.to_date_total
          shs.to_date_total = 0
          shs.save
        end
      end
    end # transaction
    flash[:success] = "Student hours for #{@user.full_name} in #{@calendar.month}/#{@calendar.year} rolled back successfully!"
    redirect_to admin_tasks_show_monthly_student_report_path
  end

  def graduate_students
      # Graduate student if enough hours
      # Get Active students (status 1) who have tuition balance of zero
      student_count = 0
      @shs = nil
      @remaining_required_sum = 0
      ProgramEnrollment.where(enrollment_status_id: 1, tuition_balance: 0).order(:id).each do |pe|
        @shs = StudentHourSummary.where(school_user_id: pe.school_user_id).order(:id).last
        @remaining_required_sum = StudentHourSummary.where(school_user_id: pe.school_user_id, year: @shs.year, month: @shs.month).sum(:remaining_required)
        if @remaining_required_sum == 0
          ActiveRecord::Base.transaction do
            ProgramEnrollment.where(school_user_id: @school_user_id, enrollment_status_id: 1).update_all(enrollment_status_id: 2, graduation_date: DateTime.now)
          end
          student_count = student_count + 1
        end
      end # each
      flash[:success] = "#{student_count} students with tution balance of 0 were graduated successfully!"
      redirect_to controller: "school_users", action: "index", id: current_school_user.school_id
  end

  private
  
    def set_params
      @students = SchoolUser.select("school_users.id, users.first_name || ' ' || users.last_name as full_name")
                                    .joins(:user).where("school_id = ? ", current_school_user.school_id)
                                    .order("users.first_name, users.last_name")
      @study_programs = StudyProgram.all.where("school_id = ? and id != ?", current_school_user.school_id, 4).order(:id)
    end
end
