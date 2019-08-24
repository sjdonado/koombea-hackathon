ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/autorun'
require 'json_matchers/minitest/assertions'

JsonMatchers.schema_root = 'test/schemas'

Minitest::Test.include(JsonMatchers::Minitest::Assertions)

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in
    # alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
