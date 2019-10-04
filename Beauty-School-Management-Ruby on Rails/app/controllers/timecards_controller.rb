class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :index]

  def index
    @timecards = current_school_user.timecards.where("clock_in > ? and processed = ?", Date.today.at_end_of_month.last_month, false)
  end

  def new
    @timecard = Timecard.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    now = Time.zone.now
    calendar = Calendar.find_by(day: now.day, month: now.month, year: now.year)
    @timecard = current_school_user.timecards.build(clock_in: now, calendar_id: calendar.id)
    respond_to do |format|
      if @timecard.save
        format.html { flash[:success] = "You are clocked in!" }
        format.js {}
      else
        render 'static_pages/home'
      end
    end
    @timecards = current_school_user.timecards.where("clock_in > ? and processed = ?", Date.today.at_end_of_month.last_month, false)
  end

  def update
    now = Time.zone.now
    @timecard = Timecard.find(params[:id])

    respond_to do |format|
      if @timecard.update_attribute(:clock_out, now)
        format.html { flash[:success] = "You are clocked out!" }
        format.js {}
        @timecards = current_school_user.timecards.where("clock_in > ? and processed = ?", Date.today.at_end_of_month.last_month, false)
      else
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @timecard.destroy
    @timecards = current_school_user.timecards.where("clock_in > ? and processed = ?", Date.today.at_end_of_month.last_month, false)
  end

  private
    
    def set_timecard
      @timecard = Timecard.find(params[:id])
    end
end
