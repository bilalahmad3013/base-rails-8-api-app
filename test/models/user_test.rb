require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid user with all attributes" do
    @user.password = "Jalnodea@123"
    assert @user.valid?
  end

  test "invalid without email_address" do
    @user.email_address = nil
    assert_not @user.valid?
  end

  test "invalid with duplicate email_address" do
    duplicate_user = @user.dup
    duplicate_user.save
    assert_not duplicate_user.valid?
  end

  test "invalid with improperly formatted email_address" do
    @user.email_address = "invalid_email_address"
    assert_not @user.valid?
  end

  test "invalid password_diegest format" do
    @user.password = "password"
    assert_not @user.valid?
  end

  test "valid password_diegest format" do
    @user.password = "Valid1!"
    assert @user.valid?
  end

  test "has one user_profile" do
    assert_respond_to @user, :user_profile
  end

  test "has many workspaces" do
    assert_respond_to @user, :workspaces
  end

end
