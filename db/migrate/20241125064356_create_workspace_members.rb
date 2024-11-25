class CreateWorkspaceMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :workspace_members do |t|
      t.references :workspace, null: false, foreign_key: true
      t.integer :member_id, null: false
      t.references :workspace_role, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :workspace_members, :users, column: :member_id
  end
end
