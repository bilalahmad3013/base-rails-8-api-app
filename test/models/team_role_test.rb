require "test_helper"

class TeamRoleTest < ActiveSupport::TestCase
  setup do
    @workspace = workspaces(:one)
    @team_role = team_roles(:one)
  end

  test "valid team role with all attributes" do
    assert @team_role.valid?
  end

  test "invalid without name" do
    @team_role.name = nil
    assert_not @team_role.valid?
    assert_includes @team_role.errors[:name], "can't be blank"
  end

  test "invalid without description" do
    @team_role.description = nil
    assert_not @team_role.valid?
    assert_includes @team_role.errors[:description], "can't be blank"
  end

  test "belongs to a workspace" do
    assert_equal @workspace, @team_role.workspace
  end
end
