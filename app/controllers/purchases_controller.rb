class PurchasesController < ApplicationController
  def index
    authorize Purchase
    @purchases = Purchase.where(purchaser_id: Current.user.id).page(params[:page]).order(created_at: :desc)
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def create
    @purchase = Purchase.new(purchase_params)
    product = Product.find(purchase_params[:product_id])
    @purchase.price = product.price

    authorize @purchase

    @purchase.save
    redirect_to product_path(product.id)
  end

  private

  def purchase_params
    params.require(:purchase).permit(:product_id)
  end
end
