class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new (approved_params)
    @pet.get_pic
    if @pet.save
      watchlist_check
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
    ext = File.extname(params[:pet][:file].original_filename)
    if (ext == ".csv") || (ext == ".xls") || (ext == ".xlsx")
      Pet.import(params[:pet][:file], current_user)
      redirect_to root_url, notice: "Pet info imported."
    else
      redirect_to sell_path, notice: "Wrong File Format"
    end
  end

  def export
    @pets = Pet.where seller_id: current_user.id
    respond_to do |format|
      format.html
      format.csv { send_data @pets.to_csv }
      format.xls { send_data @pets.to_csv(col_sep: "\t") }
    end
  end

private

  def approved_params
    params.require(:pet).permit(:species,:price,:description,:seller_id, :common_name)
  end
end
