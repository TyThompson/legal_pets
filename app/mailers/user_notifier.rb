class UserNotifier < ActionMailer::Base
  default :from => 'admin@legal-pets.herokuapp.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_watchlist_email(user, species)
    @user = user
    @species = species
    mail( :to => @user.email,
    :subject => @species + ' is available!' )
  end
end
