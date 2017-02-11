require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name: "Example User", email:"email@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "this should be valid" do 
  	assert @user.valid?
  end

  test "name should be filled" do
  	@user.name = "  "
  	assert_not @user.valid?
  end

  test "email should be filled" do
  	@user.email = "  "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid? 
  end

  test "email should not be too long" do
  	@user.email = "a"*101 + "@example.com"
  	assert_not @user.valid?
  end

  test "email format should be valid" do 
  	valid_addresses = %w[USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "no duplicate user is allowed" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid? 
  end

  test "email should be saved as lowercase" do 
	email_case = "Foo@eXampLE.com"
	@user.email = email_case
	@user.save
	assert_equal email_case.downcase, @user.reload.email
  end

  test "user password should not be blank" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid? 
  end

  test "user password should have minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

end