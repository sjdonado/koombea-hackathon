class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP } 

  belongs_to :user
  has_many :social_networks, :dependent => :destroy

  accepts_nested_attributes_for :social_networks
end
