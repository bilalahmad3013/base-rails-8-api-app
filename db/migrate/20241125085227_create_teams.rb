class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.integer :created_by_id, null: false
      t.integer :workspace_id, null: false

      t.timestamps
    end
    add_foreign_key :teams, :users, column: :created_by_id
    add_foreign_key :teams, :workspaces, column: :workspace_id
  end
end
