# frozen_string_literal: true
class WorkspaceRole < ApplicationRecord
  # Associations
  has_many :workspace_members, dependent: :destroy

  #Validations
  validates :name, presence: true
  validates :description, presence: true
end