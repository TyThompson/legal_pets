class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents

    Stripe.api_key = "sk_test_0nOTw0Tfjk6Rh8JpXi903WmV"
    @amount = 500
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    raise

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
