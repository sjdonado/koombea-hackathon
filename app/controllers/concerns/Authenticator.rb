require 'net/http'
require 'uri'

module Api
  module V1
    module Concerns
      module Authenticator
        extend ActiveSupport::Concern

        def authenticate
          header = request.headers['Authorization']
          header = header.split(' ').last if header
          # Token and user errors rescue in error handler
          payload = JsonWebToken.decode(header)
          @current_user = User.find(payload[:user_id])
        end
      end
    end
  end
end
