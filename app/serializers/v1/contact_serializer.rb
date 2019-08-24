module V1
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :address, :phone

    has_many :social_networks
  end
end
