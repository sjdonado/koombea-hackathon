module V1
  class SocialNetworkSerializer < ActiveModel::Serializer
    attributes :type, :url, :number

    def type
      object.kind
    end
  end
end
