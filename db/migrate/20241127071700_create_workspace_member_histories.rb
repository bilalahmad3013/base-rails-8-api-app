class CreateWorkspaceMemberHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :workspace_member_histories do |t|
      t.integer :member_id, null: false
      t.integer :workspace_id, null: false
      t.integer :workspace_role_id, null: false

      t.timestamps
    end
  end
end
