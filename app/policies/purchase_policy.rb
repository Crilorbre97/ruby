class PurchasePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && Purchase.find_by(product_id: record.product.id, purchaser_id: user.id).present?
  end

  def create?
    !record.product.is_owner? && !Purchase.find_by(product_id: record.product.id).present?
  end
end
