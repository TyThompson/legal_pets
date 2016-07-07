class PetPolicy < ApplicationPolicy

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
    current_user
  end
end
