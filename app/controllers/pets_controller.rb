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

private
  def approved_params
    params.require(:pet).permit(:species,:price,:description,:seller_id)
  end
end
