require 'test_helper'

class SignUpUserTest < ActionDispatch::IntegrationTest
  test "get sign up form and create new user" do
    get signup_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "votuan", email: "votuan@gmail.com", password: "password"}}
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

  end

  test "get sign up form and reject invalid account" do
    get signup_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: {user: {username: "votuan", email: "votuan@s", password: "password"}}
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
