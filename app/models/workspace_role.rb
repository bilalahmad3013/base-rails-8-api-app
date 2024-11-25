class WorkspaceRole < ApplicationRecord
  has_many :workspace_members, dependent: :destroy
end