# frozen_string_literal: true
class WorkspaceRole < ApplicationRecord
  #Validations
  validates :name, presence: true
  validates :description, presence: true
end