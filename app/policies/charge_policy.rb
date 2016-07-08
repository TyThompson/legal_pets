class ChargePolicy < ApplicationPolicy

  def create?
    is_buyer?
  end

  private

  def is_buyer?
    record.buyer == user
  end

end
