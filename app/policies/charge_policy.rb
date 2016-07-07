class ChargePolicy < ApplicationPolicy

  def create?
    current_user
  end

end
