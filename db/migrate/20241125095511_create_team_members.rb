class CreateTeamMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :team_members do |t|
      t.integer :member_id, null: false
      t.integer :team_id, null: false
      t.integer :team_role_id, null: false

      t.timestamps
    end
    add_foreign_key :team_members, :users, column: :member_id
    add_foreign_key :team_members, :teams, column: :team_id
    add_foreign_key :team_members, :team_roles, column: :team_role_id
  end
end
