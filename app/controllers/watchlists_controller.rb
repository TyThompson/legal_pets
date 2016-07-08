class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:edit, :update, :destroy]

  def index
    @watchlists = Watchlist.all
  end

  def new
    @watchlist = Watchlist.new
  end

  def create
    @watchlist = Watchlist.new (approved_params)
    if @watchlist.save
      flash[:notice] = "Watchlist created!"
      redirect_to watchlists_path
    else
      render :new
    end
  end

  def show
    @watchlist = Watchlist.find(params[:id])
  end

  def destroy
    @watchlist.destroy
    redirect_to watchlists_path, notice: 'Watchlist was successfully destroyed.'
  end

  def edit
  end

  def update
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
