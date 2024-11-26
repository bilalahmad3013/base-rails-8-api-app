# frozen_string_literal: true
class TeamRole < ApplicationRecord
  # Associations
  belongs_to :workspace

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
