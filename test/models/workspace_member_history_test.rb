require "test_helper"

class WorkspaceMemberHistoryTest < ActiveSupport::TestCase
  setup do
    @workspace_member_history = workspace_member_histories(:one)
  end

  test "valid workspace member histories with all attributes" do
    assert @workspace_member_history.valid?
  end

  test "invalid without member_id" do
    @workspace_member_history.member_id = nil
    assert_not @workspace_member_history.valid?
    assert_includes @workspace_member_history.errors[:member_id], "can't be blank"
  end

  test "invalid without workspace_id" do
    @workspace_member_history.workspace_id = nil
    assert_not @workspace_member_history.valid?
    assert_includes @workspace_member_history.errors[:workspace_id], "can't be blank"
  end

  test "invalid without workspace_role_id" do
    @workspace_member_history.workspace_role_id = nil
    assert_not @workspace_member_history.valid?
    assert_includes @workspace_member_history.errors[:workspace_role_id], "can't be blank"
  end
end
