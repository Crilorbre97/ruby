class ProductsController < ApplicationController
    skip_before_action :protect_pages, only: [ :index, :show ]

    def index
        @products = FilterProducts.new().call(product_params_filter).page(params[:page]).load_async
        @categories = Category.all.load_async
    end

    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
        @categories = Category.all
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path
        else
            @categories = Category.all
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @product = Product.find(params[:id])
        @categories = Category.all
    end

    def update
        @product = Product.find(params[:id])

        if @product.update(product_params)
            redirect_to products_path
        else
            @categories = Category.all
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to products_path
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :category_id)
    end

    def product_params_filter
        return {} unless params[:filters].present?

        params.require(:filters).permit(:title, :min_price, :max_price, :category_id, :sorting_by)
    end
end
