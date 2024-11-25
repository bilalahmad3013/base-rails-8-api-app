class CreateTeamRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :team_roles do |t|
      t.string :name
      t.string :description
      t.integer :workspace_id, null: false

      t.timestamps
    end
    add_foreign_key :team_roles, :workspaces, column: :workspace_id
  end
end
