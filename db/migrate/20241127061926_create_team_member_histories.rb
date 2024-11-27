class CreateTeamMemberHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :team_member_histories do |t|
      t.integer :member_id, null: false
      t.integer :team_role_id, null: false
      t.integer :team_id, null: false

      t.timestamps
    end
     add_foreign_key :team_member_histories, :users, column: :member_id
     add_foreign_key :team_member_histories, :team_roles, column: :team_role_id
     add_foreign_key :team_member_histories, :teams, column: :team_id
  end
end
