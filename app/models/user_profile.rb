# frozen_string_literal: true
class UserProfile < ApplicationRecord
  has_one_attached :avatar
  # Associations
  belongs_to :user

  #Validations
  validates :first_name, :last_name, :avatar, presence: true
end
