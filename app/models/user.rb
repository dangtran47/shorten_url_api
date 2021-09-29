class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5, allow_nil: true }

  def password
    @password
  end

  def password=(raw)
    @password = raw
    self.password_digest = BCrypt::Password.create(raw)
  end

  def match_password?(raw)
    Bcrypt::Password.new(password_digest).is_password?(raw)
  end
end
