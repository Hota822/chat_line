class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save {self.email.downcase!}
  validates :name, presence: true, length:{ maximum: 30},
                   uniqueness: true
  validates :email, presence: true, length:{ maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: true}
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}
end
