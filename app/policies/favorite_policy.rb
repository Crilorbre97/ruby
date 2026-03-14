class FavoritePolicy < ApplicationPolicy
  def create?
    !record.product.is_owner?
  end
end
