class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 5, allow_nil: true }

  attr_reader :password

  before_save { self.email = email.downcase }

  def password=(raw)
    @password = raw
    self.password_digest = BCrypt::Password.create(raw)
  end

  def match_password?(raw)
    BCrypt::Password.new(password_digest).is_password?(raw)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    user if user && BCrypt::Password.new(user.password_digest).is_password?(password)
  end
end
