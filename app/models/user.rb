class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :workspaces, foreign_key: :created_by_id, dependent: :destroy
  has_many :workspace_members, foreign_key: :member_id
  has_many :teams, foreign_key: :created_by_id
  has_many :team_members, foreign_key: :member_id
end
