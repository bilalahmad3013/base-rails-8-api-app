class CreateWorkspaces < ActiveRecord::Migration[8.0]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :description
      t.integer :created_by_id, null: false

      t.timestamps
    end
    add_foreign_key :workspaces, :users, column: :created_by_id
  end
end
