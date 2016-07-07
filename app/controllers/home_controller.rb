class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  def test
    UserNotifier.send_watchlist_email(current_user, 'hog').deliver
    render :index
  end
end
