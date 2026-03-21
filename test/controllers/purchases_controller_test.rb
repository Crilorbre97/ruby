require "test_helper"

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test "get index purchases" do
    get purchases_url
    assert_response :success
  end

  test "get show purchase details" do
    purchase = purchases(:sara_purchase)
    get purchase_url(purchase.id)
    assert_response :success
  end

  test "post create purchase ok" do
    product = products(:gta_5)
    user = users(:sara_user)
    assert_difference("Purchase.count", 1) do
      post purchases_url, params: {
        purchase: {
          price: product.price,
          product_id: product.id,
          purchaser: user.id
        }
      }
    end
    assert_equal @controller.instance_variable_get(:@purchase).valid?, true
    assert_response :redirect
  end

  test "post create purchase error: product already bought it" do
    product = products(:iphone_15)
    user = users(:sara_user)
    assert_raises(Pundit::NotAuthorizedError) do
      post purchases_url, params: {
        purchase: {
          price: product.price,
          product_id: product.id,
          purchaser: user.id
        }
      }
    end
  end
end
