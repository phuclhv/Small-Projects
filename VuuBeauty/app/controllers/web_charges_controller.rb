class WebChargesController < ApplicationController
  before_action :set_params
  
  TUITION_BALANCE = 1200
  
  def new
    @tuition_balance = TUITION_BALANCE
  end

  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    stripe_customer_id = customer.id

    # Amount in cents for Stripe
    charge = Stripe::Charge.create(
      :customer    => stripe_customer_id,
      :amount      => @stripe_amount,
      :description => 'Stripe microblading student web charge',
      :currency    => 'usd'
    )
    flash.now[:success] = "Your payment is processed."
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_web_charge_path
  end
  
  private
  
    # Before filters
    def set_params
      @stripe_amount = TUITION_BALANCE * 100
    end
end
