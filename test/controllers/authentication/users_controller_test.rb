class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test "get new user" do
    get new_user_url

    assert_response :success
  end

  test "post create user ok" do
    post users_url, params: {
      user: {
        name: "User",
        email: "user@gmail.com",
        phone: "657986123",
        gender: "other",
        birth_date: Date.current - 18.year,
        user_account_attributes: {
          username: "username",
          password: "testM@123",
          confirm_password: "testM@123"
        }
      }
    }

    assert_equal @controller.instance_variable_get(:@user).valid?, true
    assert_response :redirect
  end

  test "post create user error" do
    post users_url, params: {
      user: {
        name: "",
        email: "user@gmail.com",
        phone: "657986123",
        gender: "other",
        birth_date: Date.current - 18.year,
        user_account_attributes: {
          username: "username",
          password: "testM@123",
          confirm_password: "testM@123"
        }
      }
    }

    assert_equal @controller.instance_variable_get(:@user).valid?, false
    assert_response :unprocessable_entity
  end
end
