# frozen_string_literal: true
class TeamRole < ApplicationRecord
   # Associations
  belongs_to :workspace
  has_many :team_members, foreign_key: :team_role_id

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
