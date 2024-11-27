# frozen_string_literal: true
class WorkspaceMemberHistory < ApplicationRecord
  #validations
  validates :member_id, :workspace_id, :workspace_role_id, presence: true
end
