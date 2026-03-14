require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:videojuegos)
  end

  test "get category index" do
    get categories_url

    assert_response :success
  end

  test "new cagegory" do
    login_admin
    get new_category_url

    assert_response :success
  end

  test "post create category ok" do
    login_admin
    assert_difference("Category.count", 1) do
      post categories_url, params: {
        category: {
          label: "Nueva categoria"
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@category).valid?, true
    assert_response :redirect
  end

  test "post create category error" do
    login_admin
    assert_difference("Category.count", 0) do
      post categories_url, params: {
        category: {
          label: ""
        }
      }
    end

    assert_equal @controller.instance_variable_get(:@category).valid?, false
    assert_response :unprocessable_entity
  end

  test "destroy category raise exception" do
    login_admin
    assert_raise ActiveRecord::DeleteRestrictionError do
      delete category_url(@category.id)
    end
  end

  test "destroy category ok" do
    login_admin
    category = categories(:musica)
    assert_difference("Category.count", -1) do
      delete category_path(category.id)
    end

    assert_response :redirect
  end
end
