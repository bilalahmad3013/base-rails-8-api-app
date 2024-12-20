# frozen_string_literal: true
class Workspace < ApplicationRecord
  # Associations
  has_many :workspace_members, dependent: :destroy
  has_many :teams, foreign_key: :workspace_id, dependent: :destroy
  has_many :team_roles, dependent: :destroy
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  #Validations
  validates :name, presence: true
  validates :description, presence: true
end
