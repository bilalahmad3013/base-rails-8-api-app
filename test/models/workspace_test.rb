require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @workspace_role = workspace_roles(:one)
    @workspace = @user.workspaces.create(name: "Test Workspace", description: "A workspace for testing")
  end

  test "valid workspace with all attributes" do
    assert @workspace.valid?
  end

  test "invalid without name" do
    @workspace.name = nil
    assert_not @workspace.valid?
    assert_includes @workspace.errors[:name], "can't be blank"
  end

  test "invalid without description" do
    @workspace.description = nil
    assert_not @workspace.valid?
    assert_includes @workspace.errors[:description], "can't be blank"
  end

  test "belongs to creator" do
    assert_equal @user, @workspace.creator
  end

  test "has many workspace_members" do
    assert_respond_to @workspace, :workspace_members
  end

  test "has many teams" do
    assert_respond_to @workspace, :teams
  end
end
