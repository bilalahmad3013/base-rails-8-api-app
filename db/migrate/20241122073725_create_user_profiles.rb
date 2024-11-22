class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :user, null: false, foreign_key: true
      t.string :bio

      t.timestamps
    end
  end
end
