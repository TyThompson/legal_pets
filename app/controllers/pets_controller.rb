class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @pets = Pet.where(status: 'avaliable')
    authorize @pets
  end

  def user_index
    @user = User.find params[:user_id]
    @pets = @user.pets
    @pets.each do |p|
      authorize p
    end
  end

  def new
    @pet = current_user.pets.new
    authorize @pet
  end

  def edit
    @pet = Pet.find(params[:id])
    authorize @pet
  end

  def update
    @pet = Pet.find params[:id]
    authorize @pet
    if @pet.update approved_params
      flash[:notice] = "Pet information edited!"
      redirect_to @pet
    else
      render :edit
    end
  end

  def create
    @pet = Pet.new (approved_params)
    authorize @pet
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
    authorize @pet
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
    @pets = Pet.where seller_id: params[:user]
    @pets.each do |p|
      authorize p
    end
    respond_to do |format|
      format.html
      format.csv { send_data @pets.to_csv }
      format.xls { send_data @pets.to_csv(col_sep: "\t") }
    end
  end

  def export_all
    @pets = Pet.all
    authorize current_user
    respond_to do |format|
      format.html
      format.csv { send_data @pets.to_csv }
      format.xls { send_data @pets.to_csv(col_sep: "\t") }
    end
  end

private

  def approved_params
    params.require(:pet).permit(:species,:price,:description,:seller_id, :common_name, :status)
  end
end
