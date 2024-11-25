# frozen_string_literal: true
class User < ApplicationRecord
  # Associations
  has_one :user_profile, dependent: :destroy
  has_many :workspaces, foreign_key: :created_by_id, dependent: :destroy
  has_many :workspace_members, foreign_key: :member_id
  has_many :teams, foreign_key: :created_by_id
  has_many :team_members, foreign_key: :member_id

  #Validations
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates_format_of :encrypted_password, with: /\A(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%\^&*]).{6,}\z/,
                                 message: 'must include at least one uppercase letter, one number, and one special character', if: :password_required?

  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
