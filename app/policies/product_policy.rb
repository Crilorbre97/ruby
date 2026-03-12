class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    Current.user.present?
  end

  def update?
    record.is_owner?
  end

  def destroy?
    record.is_owner?
  end
end
