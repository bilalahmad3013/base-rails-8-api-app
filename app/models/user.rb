# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password
  # Associations
  has_one :user_profile, dependent: :destroy
  has_many :workspaces, foreign_key: :created_by_id, dependent: :destroy

  # Enable nested attributes for `user_profile` and `workspace`
  accepts_nested_attributes_for :user_profile

  #Validations
  validates :email_address, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates_format_of :password, with: /\A(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%\^&*]).{6,}\z/,
                                 message: 'must include at least one uppercase letter, one number, and one special character'

end
