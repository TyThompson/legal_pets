class EmailsController < ApplicationController
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

  #
  # Pony.mail :to => params[:email],
  #           :from => "friend@legal-pets.herokuapp.com",
  #           :headers => { 'Content-Type' => 'text/html' },
  #           :subject => "Price Drop on 'Legal' Pets!",
  #           :body => body = erb(:invite_email, layout: false )
  # end


end
