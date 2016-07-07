class HomePolicy
  attr_reader :user, :home

  def initialize(user, home)
    @user = user
    @home = home
  end

  def index?
    true
  end

end
