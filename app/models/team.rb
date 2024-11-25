class Team < ApplicationRecord
  belongs_to :member, class_name: "User", foreign_key: :created_by_id
  belongs_to :workspace, class_name: "Workspace", foreign_key: :workspace_id
  has_many :team_members, dependent: :destroy
end
