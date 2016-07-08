class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @watchlists = Watchlist.all
    authorize @watchlists
  end

  def new
    @watchlist = current_user.watchlists.new
    authorize @watchlist
  end

  def create
    @watchlist = Watchlist.new (approved_params)
    authorize @watchlist
    if @watchlist.save
      flash[:notice] = "Watchlist created!"
      redirect_to watchlists_path
    else
      render :new
    end
  end

  def show
    @watchlist = Watchlist.find(params[:id])
    authorize @watchlist
  end

  def destroy
    authorize @watchlist
    @watchlist.destroy
    redirect_to watchlists_path, notice: 'Watchlist was successfully destroyed.'
  end

  def edit
    authorize @watchlist
  end

  def update
    authorize @watchlist
    if @watchlist.update(approved_params)
      redirect_to @watchlist, notice: 'Watchlist was successfully updated.'
    else
      render :edit
    end
  end

  private
    def approved_params
      params.require(:watchlist).permit(:species,:price,:user_id)
    end

    def set_watchlist
      @watchlist = Watchlist.find(params[:id])
    end
end
