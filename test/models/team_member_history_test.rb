require "test_helper"

class TeamMemberHistoryTest < ActiveSupport::TestCase
  setup do
    @team_member_history = team_member_histories(:one)
  end

  test "valid workspace member histories with all attributes" do
    assert @team_member_history.valid?
  end

  test "invalid without member_id" do
    @team_member_history.member_id = nil
    assert_not @team_member_history.valid?
    assert_includes @team_member_history.errors[:member_id], "can't be blank"
  end

  test "invalid without workspace_id" do
    @team_member_history.team_id = nil
    assert_not @team_member_history.valid?
    assert_includes @team_member_history.errors[:team_id], "can't be blank"
  end

  test "invalid without workspace_role_id" do
    @team_member_history.team_role_id = nil
    assert_not @team_member_history.valid?
    assert_includes @team_member_history.errors[:team_role_id], "can't be blank"
  end
end
