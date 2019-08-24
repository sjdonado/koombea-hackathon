class User < ApplicationRecord
  has_one_attached :photo
  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
