class FavoritePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    !record.product.is_owner? && !record.product.favorite
  end

  def destroy?
    !record.product.is_owner? && record.product.favorite
  end
end
