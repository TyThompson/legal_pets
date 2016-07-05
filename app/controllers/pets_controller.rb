class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new (approved_params)
    if @pet.save
      flash[:notice] = "Legal pet sale created!"
      redirect_to pets_path
    else
      render :new
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @stripe_price = (@pet.price.to_f * 10).to_s.gsub('.','')
  end

  def import
    Pet.import(params[:pet][:file], current_user)
    redirect_to root_url, notice: "Pet info imported."
  end

private


  def approved_params
    params.require(:pet).permit(:species,:price,:description,:seller_id)
  end
end
