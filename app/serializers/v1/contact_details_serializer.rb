module V1
  class ContactDetailsSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :address, :phone, :user

    has_many :social_networks

    def user
      UserSerializer.new(object.user).as_json unless object.user.nil?
    end
  end
end
