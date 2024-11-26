require "test_helper"

class WorkspaceMemberTest < ActiveSupport::TestCase
  setup do
    @user = users(:two)
    @workspace = workspaces(:one)
    @workspace_role = workspace_roles(:one)
    @workspace_member = workspace_members(:one)
  end

  test "valid workspace member with all attributes" do
    assert @workspace_member.valid?
  end

  test "invalid without workspace" do
    @workspace_member.workspace = nil
    assert_not @workspace_member.valid?
    assert_includes @workspace_member.errors[:workspace], "must exist"
  end

  test "invalid without member" do
    @workspace_member.workspace_member = nil
    assert_not @workspace_member.valid?
    assert_includes @workspace_member.errors[:workspace_member], "must exist"
  end

  test "invalid without workspace_role" do
    @workspace_member.workspace_role = nil
    assert_not @workspace_member.valid?
    assert_includes @workspace_member.errors[:workspace_role], "must exist"
  end
end
