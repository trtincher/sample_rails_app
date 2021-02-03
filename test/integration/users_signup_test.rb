require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    user_params = { name:  "",email: "user@invalid",password:"foo",password_confirmation: "bar" }
    assert_no_difference 'User.count' do
                      # integration test have to have explicite params like this now (unlike in the book)
      post users_path, params: {user: user_params}
    end
    assert_template 'users/new'
  end


  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }}
      follow_redirect!
    end
    assert_template "users/show"
  end
end