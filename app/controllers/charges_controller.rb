class ChargesController < ApplicationController

  protect_from_forgery except: :create

  def create
    # Amount in cents

    Stripe.api_key = "sk_test_0nOTw0Tfjk6Rh8JpXi903WmV"
    @amount = params[:price].to_i
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

    if charge.paid
      pet = Pet.find params[:pet_id]
      pet.status = "sold"
      pet.buyer = current_user
      pet.save
      redirect_to pet_path(pet), notice: "Congratulations, you purchased the #{pet.common_name}!"
    else
      redirect_to pet_path(pet), notice: "Sorry, your card was declined"
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
