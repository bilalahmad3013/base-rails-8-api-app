require "test_helper"

class TeamMemberTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @workspace = workspaces(:one)
    @team = teams(:one)
    @team_role = team_roles(:one)
    @team_member = TeamMember.new(member_id: @user.id, team: @team, team_role: @team_role)
  end

  test "valid team member with all attributes" do
    assert @team_member.valid?
  end

  test "invalid without member" do
    @team_member.member_id = nil
    assert_not @team_member.valid?
    assert_includes @team_member.errors[:team_member], "must exist"
  end

  test "invalid without team" do
    @team_member.team = nil
    assert_not @team_member.valid?
    assert_includes @team_member.errors[:team], "must exist"
  end

  test "invalid without team_role" do
    @team_member.team_role = nil
    assert_not @team_member.valid?
    assert_includes @team_member.errors[:team_role], "must exist"
  end

  test "belongs to a user as member" do
    assert_equal @user, @team_member.team_member
  end

  test "belongs to a team" do
    assert_equal @team, @team_member.team
  end

  test "belongs to a team role" do
    assert_equal @team_role, @team_member.team_role
  end
end
