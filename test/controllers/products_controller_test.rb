require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:nintendo)
    @category = categories(:videojuegos)
  end

  test "get products" do
    get products_path

    assert_response :success
  end

  test "filter products by title" do
    get products_path, params: {
      filters: {
        title: "nintendo"
      }
    }

    products = @controller.instance_variable_get(:@products)
    assert_equal products.all? { |p| p.title.downcase.include? "nintendo" }, true
    assert_response :success
  end

  test "filter products by prices" do
    get products_path, params: {
      filters: {
        min_price: "1",
        max_price: "10"
      }
    }

    products = @controller.instance_variable_get(:@products)
    assert_equal products.all? { |p| p.price >= 1 && p.price <= 10 }, true
    assert_response :success
  end

  test "filter products by category_id" do
    get products_path, params: {
      filters: {
        category_id: @category.id
      }
    }

    products = @controller.instance_variable_get(:@products)
    assert_equal products.all? { |p| p.category.id == @category.id }, true
    assert_response :success
  end

  test "filter products by user_id" do
    user = users(:sara_user)
    get products_path, params: {
      filters: {
        user_id: user.id.to_s
      }
    }

    products = @controller.instance_variable_get(:@products)
    # Another form
    # assert_equal products.pluck(:user_id).uniq, [ user.id ]
    assert_equal products.all? { |p| p.user.id == user.id }, true
    assert_response :success
  end

  test "get product" do
    get product_path(@product.id)

    assert_response :success
  end

  test "new product" do
    login_user
    get new_product_path

    assert_response :success
  end

  test "create product success" do
    login_user
    assert_difference("Product.count", 1) do
      post products_path, params: {
        product: {
          title: "Mesa",
          description: "Mesa para comedor",
          price: 10,
          category_id: @category.id
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@product).valid?, true
    assert_response :redirect
  end

  test "create product error" do
    login_user
    assert_difference("Product.count", 0) do
      post products_path, params: {
        product: {
          title: "",
          description: "",
          price: 10
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@product).valid?, false
    assert_response :unprocessable_entity
  end

  test "edit product" do
    login_user
    get edit_product_path(@product.id)

    assert_response :success
  end

  test "update product ok" do
    login_user
    patch product_path(@product.id), params: {
      product: {
        title: "Updated title"
      }
    }

    assert_equal @controller.instance_variable_get(:@product).valid?, true
    assert_equal @product.reload.title, "Updated title"
    assert_response :redirect
  end

  test "update product error" do
    login_user
    patch product_path(@product.id), params: {
      product: {
        title: ""
      }
    }

    assert_equal @controller.instance_variable_get(:@product).valid?, false
    assert_equal @product.reload.title, @product.title
    assert_response :unprocessable_content
  end

  test "destroy product" do
    login_user
    assert_difference("Product.count", -1) do
      delete product_path(@product.id)
    end

    assert_response :redirect
  end
end
