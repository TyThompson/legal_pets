class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  if ENV["SENDGRID_USERNAME"]
    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'legal-pets.herokuapp.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    }
  end

  def watchlist_check
    contact = Watchlist.where("price < ?", @pet.price).where(species: @pet.species)
      contact.each do |p|
      Pony.mail :to => p.user.email,
                :from => "friend@legal-pets.herokuapp.com",
                :headers => { 'Content-Type' => 'text/html' },
                :subject => "Pet available on 'Legal' Pets!",
                :body => 'pet_available_email'
      end
  end
end
