# test/controllers/user_controller_test.rb

require 'test_helper'

class UserControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @valid_attributes = {
      user: {
        email_address: 'test@example.com',
        password: 'Password@123',
        user_profile_attributes: {
          first_name: 'John',
          last_name: 'Doe'
        },
        workspaces_attributes: {
          name: 'Test Workspace',
          description: 'A workspace for testing'
        }
      }
    }
    @invalid_attributes = {
      user: {
        email_address: '',
        password: '',
        user_profile_attributes: {
          first_name: '',
          last_name: ''
        },
        workspaces_attributes: {
          name: '',
          description: ''
        }
      }
    }
  end

  test "should create user and workspace" do
    assert_difference('User.count') do
      post :create, params: @valid_attributes
    end
    assert_response :success
  end

  test "should not create user with invalid attributes" do
    assert_no_difference('User.count') do
      post :create, params: @invalid_attributes
    end
    assert_response :bad_request
  end

  test "should destroy user" do
    token = JsonWebToken.encode(user_id: @user.id)
    @request.headers['Authorization'] = "#{token}"
    assert_difference('User.count', -1) do
      delete :destroy
    end
    assert_response :success
  end

  test "should confirm user" do
    user = User.create!(email_address: 'confirm@example.com', password: 'Password@123', confirmation_token: 'token123')
    get :confirm, params: { token: user.confirmation_token }
    assert_redirected_to "#{ENV['FRONTEND_URL']}?confirmation_status=true"
    user.reload
    assert user.confirmed?
  end

  test "should not confirm user with invalid token" do
    get :confirm, params: { token: 'invalid_token' }
    assert_redirected_to "#{ENV['FRONTEND_URL']}?confirmation_status=true"
  end
end