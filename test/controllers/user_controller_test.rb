# test/controllers/user_controller_test.rb
require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_attributes = { email_address: 'test@example.com', password: 'password123', user_profile_attributes: { first_name: 'John', last_name: 'Doe' } }
    @invalid_attributes = { email_address: '', password: '', user_profile_attributes: { first_name: '', last_name: '' } }
    @valid_workspace_attributes = { workspaces_attributes: { name: 'Test Workspace', description: 'Workspace description' } }
    @user = users(:one)
  end

  test "should create user and workspace" do
    assert_difference('User.count') do
      assert_difference('Workspace.count') do
        post user_index_path, params: { user: @valid_attributes.merge(@valid_workspace_attributes) }
      end
    end
    assert_response :success
    assert_includes @response.body, 'Account and workspace created successfully'
  end
end
