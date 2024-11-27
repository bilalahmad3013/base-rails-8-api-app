# frozen_string_literal: true
class Team < ApplicationRecord
  # Associations
  has_many :team_members, dependent: :destroy

  belongs_to :workspace, class_name: "Workspace", foreign_key: :workspace_id

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
