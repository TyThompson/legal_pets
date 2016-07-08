class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :test]

  def index
  end

  def test
    UserNotifier.send_watchlist_email(current_user, 'hog').deliver
    render :index
  end
end
