require "test_helper"

class WorkspaceRoleTest < ActiveSupport::TestCase
  setup do
    @workspace_role = workspace_roles(:one)
  end

  test "valid workspace role with all attributes" do
    assert @workspace_role.valid?
  end

  test "invalid without name" do
    @workspace_role.name = nil
    assert_not @workspace_role.valid?
  end

  test "invalid without description" do
    @workspace_role.description = nil
    assert_not @workspace_role.valid?
  end
end
