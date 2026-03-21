require "test_helper"

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test "get index purchases" do
    get purchases_url
    assert_redirect :success
  end

  test "get show purchase details" do
  end

  test "post create purchase ok" do
  end

  test "post create purchase error: product already bought it" do
  end
end
