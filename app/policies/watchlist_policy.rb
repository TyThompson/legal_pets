class WatchlistPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    current_user
  end

  def show?
    current_user
  end

end
