module V1
  module Concerns
    module ErrorHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound do |e|
          render_error(:not_found, e)
        end
        rescue_from JWT::DecodeError do |e|
          render_error(:unauthorized, nil, "Token error: #{e.message}")
        end
        rescue_from ApiError do |e|
          render_error(e.status, e)
        end
        # rescue_from StandardError do |e|
        #   render_error(e.status, e)
        # end
      end

      def render_error(status, error = nil, msg = nil)
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        details = msg || Rack::Utils::HTTP_STATUS_CODES[status_code]
        details = error.message if error
        render json: {
          errors: [{
            details: details
          }]
        }, status: status
      end
    end
  end
end
