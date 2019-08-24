module Api
  module V1
    class BaseController < ApplicationController
      include Concerns::Authenticator

      private

      def auth(roles)
        has_one_authorized_role = roles.include? @current_user[:role].to_sym
        raise ApiError, :forbidden unless has_one_authorized_role
      end
    end
  end
end
