class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test "get new user" do
    get new_user_url

    assert_response :success
  end

  test "post create user ok" do
    stub_unsplash_random_photo(200, { urls: { raw: "random_url" } }.to_json)
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

  private

  def stub_unsplash_random_photo(status_code, body = nil)
    stub_request(:get, "http://fake.unsplash.test:80/photos/random").
      with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "Client-ID fake_access_key",
          "Host" => "fake.unsplash.test"
        }
      )
      .to_return(status: status_code, body: body, headers: {})
  end
end
