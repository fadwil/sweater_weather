class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(32) if api_key.blank?
  end
end
