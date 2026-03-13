class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    is_user_admin?
  end

  def destroy?
    is_user_admin?
  end

  private

  def is_user_admin?
    user.is_admin?
  end
end
