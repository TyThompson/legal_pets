class UserPolicy < ApplicationPolicy

  def show?
    current_user
  end

end
