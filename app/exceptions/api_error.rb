class ApiError < StandardError
  attr_reader :status, :error, :message

  class << self
    attr_accessor :errors
  end

  @errors = {
    0 => 'Password and confirm_password does not match',
    1 => 'Invalid token',
    2 => 'User not found'
  }

  def initialize(status, error = nil, message = nil)
    @status = status
    @error = error || Rack::Utils::SYMBOL_TO_STATUS_CODE[@status]
    @message = message || Rack::Utils::HTTP_STATUS_CODES[@error]
  end
end
