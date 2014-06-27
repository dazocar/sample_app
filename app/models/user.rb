class User < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :name,  presence: true, length: { maximum: 50 },
                      uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }

    has_secure_password

    before_save :set_downcaseEmail

    def set_downcaseEmail
      self.email = email.downcase
    end
end
