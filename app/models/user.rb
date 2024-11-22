class User < ApplicationRecord
  has_secure_password
  has_one  :user_profile, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
