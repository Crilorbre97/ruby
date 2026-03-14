class FavoritesController < ApplicationController
  def index
    authorize Favorite

    @favorites = Favorite.where(user: Current.user.id)
  end

  def create
    @favorite = Favorite.new(favotire_params)
    authorize @favorite

    @favorite.save
    redirect_to product_path(@favorite.product.id)
  end

  def destroy
    @favorite = Favorite.find_by(product: params[:id], user: Current.user.id)
    authorize @favorite

    @favorite.destroy
    redirect_to product_path(@favorite.product.id)
  end

  private

  def favotire_params
    params.permit(:product_id)
  end
end
