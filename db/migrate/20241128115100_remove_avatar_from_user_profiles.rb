class RemoveAvatarFromUserProfiles < ActiveRecord::Migration[8.0]
  def change
    remove_column :user_profiles, :avatar, :string
  end
end
