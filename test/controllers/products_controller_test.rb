class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:nintendo)
  end

  test 'get products' do
    get products_path

    assert_response :success
  end

  test 'get product' do
    get product_path(@product.id)

    assert_response :success
  end

  test 'new product' do
    get new_product_path

    assert_response :success
  end

  test 'create product success' do
    assert_difference("Product.count", 1) do
      post products_path, params: {
        product: {
          title: 'Mesa',
          description: 'Mesa para comedor',
          price: 10
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@product).valid?, true
    assert_response :redirect
  end

  test 'create product error' do
    assert_difference("Product.count", 0) do
      post products_path, params: {
        product: {
          title: '',
          description: '',
          price: 10
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@product).valid?, false
    assert_response :unprocessable_entity
  end

  test 'edit product' do
    get edit_product_path(@product.id)

    assert_response :success
  end

  test 'update product ok' do
    patch product_path(@product.id), params: {
      product: {
        title: "Updated title"
      }
    }

    assert_equal @controller.instance_variable_get(:@product).valid?, true
    assert_equal @product.reload.title, "Updated title"
    assert_response :redirect
  end

  test 'update product error' do
    patch product_path(@product.id), params: {
      product: {
        title: ""
      }
    }

    assert_equal @controller.instance_variable_get(:@product).valid?, false
    assert_equal @product.reload.title, @product.title
    assert_response :unprocessable_content
  end

  test 'destroy product' do
    assert_difference("Product.count", -1) do
      delete product_path(@product.id)
    end

    assert_response :redirect
  end
end