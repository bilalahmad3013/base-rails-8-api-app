class Workspace < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id
  has_many :workspace_members, dependent: :destroy
  has_many :members, through: :workspace_members, source: :member, dependent: :destroy
  has_many :teams, foreign_key: :workspace_id, dependent: :destroy
  has_many :team_roles, dependent: :destroy
end
