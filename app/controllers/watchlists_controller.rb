class WatchlistsController < ApplicationController
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

  private
    def approved_params
      params.require(:watchlist).permit(:species,:price,:user_id)
    end
end
