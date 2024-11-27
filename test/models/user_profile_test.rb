require "test_helper"

class UserProfileTest < ActiveSupport::TestCase
  setup do
    @user_profile = user_profiles(:one)
  end

  test "valid user profile with all attributes" do
    assert @user_profile.valid?
  end

  test "invalid without first_name" do
    @user_profile.first_name = nil
    assert_not @user_profile.valid?
    assert_includes @user_profile.errors[:first_name], "can't be blank"
  end

  test "invalid without last_name" do
    @user_profile.last_name = nil
    assert_not @user_profile.valid?
    assert_includes @user_profile.errors[:last_name], "can't be blank"
  end

  test "invalid without avatar" do
    @user_profile.avatar = nil
    assert_not @user_profile.valid?
    assert_includes @user_profile.errors[:avatar], "can't be blank"
  end

  test "belongs to a user" do
    assert_equal users(:one), @user_profile.user
  end
end
