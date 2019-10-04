class PaymentsController < ApplicationController
  before_action :logged_in_user
  
  def index
    school_user_id = current_school_user.id
    @program_enrollment = ProgramEnrollment.find_by(school_user_id: school_user_id)
    @tuition_balance = @program_enrollment.tuition_balance
    @payments = Payment.all.where(school_user_id: school_user_id)
  end
end
