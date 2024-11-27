class AddUniqueIndexToTeamMemberHistories < ActiveRecord::Migration[8.0]
  def change
    add_index :team_member_histories, [:team_role_id, :team_id, :member_id], unique: true, name: 'index_team_member_histories_on_role_and_team'
  end
end
