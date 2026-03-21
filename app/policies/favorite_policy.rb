class FavoritePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    !record.product.is_owner? && !record.product.favorite
  end

  def destroy?
    !record.product.is_owner? && record.product.favorite
  end
end
