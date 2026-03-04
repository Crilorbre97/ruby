class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:videojuegos)
  end

  test 'get index' do
    get categories_url

    assert_response :success
  end

  test 'get new' do
    get new_category_url

    assert_response :success
  end

  test 'post create ok' do
    assert_difference("Category.count", 1) do
      post categories_url, params: {
        category: {
          label: 'Nueva categoria'
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@category).valid?, true
    assert_response :redirect
  end

  test 'post create error' do
    assert_difference("Category.count", 0) do
      post categories_url, params: {
        category: {
          label: ''
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@category).valid?, false
    assert_response :unprocessable_entity
  end

  test 'destroy raise exception' do
    assert_raise ActiveRecord::DeleteRestrictionError do
      delete category_url(@category.id)
    end
  end

  test 'destroy ok' do
    category = categories(:musica)
    assert_difference("Category.count", -1) do
      delete category_path(category.id)
    end

    assert_response :redirect
  end
end