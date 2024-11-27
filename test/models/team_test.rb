require "test_helper"

class TeamTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @workspace = workspaces(:one)
    @team = teams(:one)
  end

  test "valid team with all attributes" do
    assert @team.valid?
  end

  test "invalid without name" do
    @team.name = nil
    assert_not @team.valid?
    assert_includes @team.errors[:name], "can't be blank"
  end

  test "invalid without description" do
    @team.description = nil
    assert_not @team.valid?
    assert_includes @team.errors[:description], "can't be blank"
  end

  test "belongs to a workspace" do
    assert_equal @workspace, @team.workspace
  end

  test "has many team members" do
    team_member = TeamMember.create(member_id: User.first.id, team_id: @team.id, team_role_id: TeamRole.first.id)
    @team.team_members << team_member
    assert_includes @team.team_members, team_member
  end
end
