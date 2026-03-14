class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(favotire_params)
    authorize @favorite

    @favorite.save
    redirect_to product_path(@favorite.product.id)
  end

  private

  def favotire_params
    params.permit(:product_id)
  end
end
