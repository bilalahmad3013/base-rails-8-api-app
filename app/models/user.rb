# frozen_string_literal: true
class User < ApplicationRecord
  # Associations
  has_one :user_profile, dependent: :destroy
  has_many :workspaces, foreign_key: :created_by_id, dependent: :destroy

  #Validations
  validates :email_address, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates_format_of :password_digest, with: /\A(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%\^&*]).{6,}\z/,
                                 message: 'must include at least one uppercase letter, one number, and one special character'

end
