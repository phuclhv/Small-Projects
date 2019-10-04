class ChargesController < ApplicationController
  before_action :logged_in_user
  before_action :set_params
  
  def new
  end

  def create
    if @payment.nil? || @payment.stripe_customer_id.nil? || @payment.stripe_customer_id == 0
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      stripe_customer_id = customer.id
    else
      stripe_customer_id = @payment.stripe_customer_id
    end
    # Amount in cents for Stripe
    charge = Stripe::Charge.create(
      :customer    => stripe_customer_id,
      :amount      => @stripe_amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    # Save payment into the app
    @school_user_id = @program_enrollment.school_user_id
    payment = Payment.new(amount: @amount, payment_date: Time.zone.now,
                          school_user_id: @school_user_id,
                          stripe_customer_id: stripe_customer_id,
                          payment_type_id: 3) # 3 is CC
    if payment.save
      @tuition_balance = @program_enrollment.tuition_balance - @amount
      @program_enrollment.update_columns(tuition_balance: @tuition_balance)
      @user = current_user
      @user.send_tuition_payment_email(@amount, @tuition_balance)
      @payments = Payment.all.where(school_user_id: @school_user_id)
      flash.now[:success] = "Your payment is processed."
    else
      flash[:error] = "Something's wrong.  Please contact vuubeautyschool@gmail.com."
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  
  private
  
    # Before filters
    def set_params
      @program_enrollment = ProgramEnrollment.find_by(school_user_id: current_school_user.id)
      @payment = Payment.find_by(school_user_id: current_school_user.id)
      @study_program = StudyProgram.all.where(id: @program_enrollment.study_program_id).first
      if @study_program.nil?
        @monthly_payment = 300
        @first_payment = 400
      else
        @monthly_payment  = @study_program.monthly_payment
        @first_payment =  @study_program.first_payment
      end
      if !@payment.nil?
        if @monthly_payment < @program_enrollment.tuition_balance
          @amount = @monthly_payment
        else
          @amount = @program_enrollment.tuition_balance
        end
      else
        @amount = @first_payment
      end
      @stripe_amount = @amount * 100
    end
end
