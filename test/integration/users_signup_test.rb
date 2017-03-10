require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do 
  	get signupuser_path
  	assert_no_difference 'User.count' do
  		post signupuser_path, params: { user: {  name: " ", 
                    										 email: "user@invalid", 
                    										 password: 				      "foo",
                    										 password_confirmation: "bar" } }
  	end
  	assert_template 'users/new'
    assert_select '.field_with_errors'
    assert_select '#error_explanation'
    assert_select 'form[action="/signupuser"]'
  end

  test "valid signup information" do
    get signupuser_path 
    assert_difference 'User.count', 1 do
      post signupuser_path, params: { user: {  name: "Example user", 
                                         email: "user@example.com", 
                                         password:              "12345678",
                                         password_confirmation: "12345678" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end