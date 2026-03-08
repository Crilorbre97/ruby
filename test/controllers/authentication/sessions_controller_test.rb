class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "get session" do
    get new_session_url

    assert_response :success
  end

  test "post session ok" do
    post sessions_url, params: {
      session_form: {
          username: "sarah",
          password: "Contr@seña1"
      }
    }

    assert_equal @controller.instance_variable_get(:@session).valid?, true
    assert_response :redirect
    assert_redirected_to products_path
  end

  test "post session not found user" do
    post sessions_url, params: {
      session_form: {
          username: "username",
          password: "testM@123"
      }
    }

    assert_equal @controller.instance_variable_get(:@session).valid?, true
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "post session form error" do
    post sessions_url, params: {
      session_form: {
          username: "",
          password: "testM@123"
      }
    }

    assert_equal @controller.instance_variable_get(:@session).valid?, false
    assert_response :unprocessable_entity
  end
end
