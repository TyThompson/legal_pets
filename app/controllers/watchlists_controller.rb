class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:show, :edit, :update, :destroy]

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
    @watchlist = Watchlist.find(user_id: current_user)
  end

  def destroy
    @watchlist.destroy
    redirect_to watchlists_path, notice: 'Watchlist was successfully destroyed.'
  end

  private
    def approved_params
      params.require(:watchlist).permit(:species,:price,:user_id)
    end

    def set_watchlist
      @watchlist = Watchlist.find(params[:id])
    end
end
