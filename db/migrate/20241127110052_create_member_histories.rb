class CreateMemberHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :member_histories do |t|
      t.integer :member_id, null: false
      t.integer :workspace_id, null: false
      t.integer :workspace_role_id, null: false
      t.integer :team_id, null: true
      t.integer :team_role_id, null: true

      t.timestamps
    end
    add_foreign_key :member_histories, :users, column: :member_id
    add_foreign_key :member_histories, :workspaces, column: :workspace_id
    add_foreign_key :member_histories, :workspace_roles, column: :workspace_role_id
    add_foreign_key :member_histories, :teams, column: :team_id
    add_foreign_key :member_histories, :team_roles, column: :team_role_id
  end
end
