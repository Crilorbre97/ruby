class FavoritesController < ApplicationController
  def index
    authorize Favorite

    @favorites = Favorite.where(user: Current.user.id)
  end

  def create
    @favorite = Favorite.new(favotire_params)
    authorize @favorite

    if @favorite.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: @favorite.product })
        end
        format.html { redirect_to product_path(@favorite.product.id) }
      end
    end
  end

  def destroy
    @favorite = Favorite.find_by(product: params[:id], user: Current.user.id)
    authorize @favorite

    if @favorite.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: @favorite.product })
        end
        format.html { redirect_to product_path(@favorite.product.id) }
      end
    end
  end

  private

  def favotire_params
    params.permit(:product_id)
  end
end
