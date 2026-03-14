require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test "get favorite list" do
    get favorites_path

    assert_response :success
  end
  test "mark product as favorite" do
    product = products(:mesa_comedor)
    post favorites_path, params: {
      product_id: product.id
    }

    assert_response :redirect
    assert_not_nil Favorite.find_by(product: product.id, user: users(:sara_user).id)
  end

  test "unmark product as favorite" do
    product = products(:silla_exterior)
    delete favorite_path(product.id)

    assert_response :redirect
    assert_nil Favorite.find_by(product: product.id, user: users(:sara_user).id)
  end
end
