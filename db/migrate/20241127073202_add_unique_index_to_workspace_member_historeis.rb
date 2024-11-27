class AddUniqueIndexToWorkspaceMemberHistoreis < ActiveRecord::Migration[8.0]
  def change
    add_index :workspace_member_histories, [:workspace_id, :workspace_role_id, :member_id], unique: true, name: 'index_workspace_member_histories'
  end
end
