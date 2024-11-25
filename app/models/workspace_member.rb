# frozen_string_literal: true
class WorkspaceMember < ApplicationRecord
  # Associations
  belongs_to :workspace
  belongs_to :member, class_name: "User", foreign_key: :member_id
  belongs_to :workspace_role
end
