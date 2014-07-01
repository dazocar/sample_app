class User < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :name,  presence: true, length: { maximum: 50 },
    uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }

    has_secure_password

    before_save :set_downcaseEmail
    before_create :create_remember_token

    def set_downcaseEmail
      self.email = email.downcase
    end

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    private
        def create_remember_token
          self.remember_token = User.digest(User.new_remember_token)
        end
end
