# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirmation_token
  before_destroy :destroy_member_history
  after_create :send_confirmation
  # Associations
  has_one :user_profile, dependent: :destroy
  has_many :workspaces, foreign_key: :created_by_id, dependent: :destroy

  # Enable nested attributes for `user_profile` and `workspace`
  accepts_nested_attributes_for :user_profile

  #Validations
  validates :email_address, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates_format_of :password, :with => /\A(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%\^&*]).{6,}\z/,
                                 message: 'must include at least one uppercase letter, one number, and one special character'


  def generate_confirmation_token
    self.confirmation_token = SecureRandom.hex(16)
    self.confirmation_sent_at = Time.current
  end

  def confirm!
    update_columns(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmation_expired?
    confirmation_sent_at < 24.hours.ago
  end

  private

  def send_confirmation
    UserMailer.confirmation_email(self).deliver_now
  end

  def destroy_member_history
   member_histroy = MemberHistory.where(member_id: self.id)
   member_histroy.destroy_all
  end
end
