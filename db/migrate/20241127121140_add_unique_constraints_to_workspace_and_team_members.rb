class AddUniqueConstraintsToWorkspaceAndTeamMembers < ActiveRecord::Migration[8.0]
  def change
    # Add unique index for WorkspaceMember table
    add_index :workspace_members, [:workspace_id, :member_id, :workspace_role_id], unique: true, name: 'index_workspace_members_on_workspace_member_role'

    # Add unique index for TeamMember table
    add_index :team_members, [:team_id, :member_id, :team_role_id], unique: true, name: 'index_team_members_on_team_member_role'

    # Add unique index for MemberHistory table
    add_index :member_histories, [:member_id, :workspace_id, :workspace_role_id], unique: true, name: 'index_member_histories_on_member_workspace_role', where: 'team_id IS NULL AND team_role_id IS NULL'
    add_index :member_histories, [:member_id, :workspace_id, :team_id, :team_role_id, :workspace_role_id], unique: true, name: 'index_for_unique'
  end
end
