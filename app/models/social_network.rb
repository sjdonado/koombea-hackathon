class SocialNetwork < ApplicationRecord
  enum kind: %i[
    Facebook Whatsapp Twitter Instagram LinkedIn Pinterest Reddit Youtube
  ]
  validates :kind, :url, :number, presence: true

  belongs_to :contact
end
