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
        # p "@CURRENT_TOKEN", @current_token
        # p @current_user.last_token

        token_val = @current_user.last_token == @current_token
        render_error(:bad_request, nil, ApiError.errors[1]) if token_val
      end
    end
  end
end
