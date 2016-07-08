class PetPolicy < ApplicationPolicy

  def index?
    true
  end

  def user_index?
    is_seller? || is_admin? || is_user?
  end

  def create?
    is_seller?
  end

  def new?
    true
  end

  def show?
    true
  end

  def import?
    is_user? || is_admin?
  end

  def export?
    is_seller? || is_admin?
  end

  def update?
    is_seller? || is_admin?
  end

  private

  def is_user?
    record.user == user
  end

  def is_seller?
    user == record.seller
  end

  def is_admin?
    unless user.nil?
      user.admin?
    end
  end
end
