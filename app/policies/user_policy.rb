class UserPolicy < ApplicationPolicy

  def show?
    is_user? || is_admin?
  end

  def export_all?
    is_admin?
  end

  def export?
    is_user? || is_admin?
  end

  def user_index?
    is_user? || is_admin?
  end

  def create?
    is_user?
  end

  private

  def is_user?
    record == user
  end

  def is_admin?
    unless user.nil?
      user.admin?
    end
  end

end
