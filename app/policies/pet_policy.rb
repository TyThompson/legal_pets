class PetPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def index?
    true
  end

  def create?
    current_user
  end

  def show?
    true
  end

  def import?
    current_user
  end

  def export?
    current_user
  end

  def update?
    user.admin? or not post.published?
  end
end
