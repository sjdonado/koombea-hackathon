module V1
  class UserSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :name, :email, :address, :phone, :photo_url

    def photo_url
      url_for(object.photo) if object.photo.attached?
    end
  end
end
