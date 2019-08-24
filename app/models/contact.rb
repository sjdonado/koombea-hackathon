class Contact < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :owner, class_name: 'User'
  belongs_to :user, class_name: 'User', optional: true

  has_many :social_networks, dependent: :destroy

  accepts_nested_attributes_for :social_networks
end
