class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def watchlist_check
    contact = Watchlist.where("price < ?", @pet.price).where(species: @pet.species)
      contact.each do |p|
        UserNotifier.send_watchlist_email(p.user, @pet.species).deliver
      end
  end


end
