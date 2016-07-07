class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def watchlist_check
    contact = Watchlist.where("price < ?", @pet.price).where(species: @pet.species)
      contact.each do |p|
      Pony.mail :to => p.user.email,
                :from => "friend@legal-pets.herokuapp.com",
                :headers => { 'Content-Type' => 'text/html' },
                :subject => "Pet available on 'Legal' Pets!",
                :body => "The pet you were waiting for is available for #{@pet.price}"
      end
  end
end
