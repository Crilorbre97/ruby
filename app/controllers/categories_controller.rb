class CategoriesController < ApplicationController
  skip_before_action :protect_pages, only: [ :index ]

  def index
    authorize Category
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:label)
  end
end
