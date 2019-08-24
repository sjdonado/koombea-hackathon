# require 'net/http'
# require 'uri'
module V1
  module Concerns
    module Authenticator
      extend ActiveSupport::Concern

      def authenticate
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        @current_token = header
        # Token and user errors rescue in error handler
        payload = JsonWebToken.decode(header)
        @current_user = User.find(payload[:user_id])
        p "@CURRENT_TOKEN", @current_token
        p @current_user.last_token

        if @current_user.last_token == @current_token
          p "LOGOUT ENTRY"
          render_error(:bad_request, nil, ApiError.errors[1])
        end
      end
    end
  end
end
