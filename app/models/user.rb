
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password_digest, :session_token, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true

    attr_reader :password
    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def password=(pass)
        @password = pass
        self.password_digest = BCrypt::Password.create(pass)
    end

    def is_password?(pass)
        BCrypt::Password.new(self.password_digest).is_password?(pass)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        user if user && user.is_password?(password)
    end



end