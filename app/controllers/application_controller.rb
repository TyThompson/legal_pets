class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def watchlist_check
    contact = Watchlist.where("price < ?", @pet.price).where(species: @pet.species)
      contact.each do |p|
        UserNotifier.send_watchlist_email(p.user, @pet.species).deliver
      end
  end


end
