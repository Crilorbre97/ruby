ENV["RAILS_ENV"] ||= "test"
ENV["UNSPLASH_URL"]="http://fake.unsplash.test"
ENV["UNSPLASH_ACCESS_KEY"]="fake_access_key"
require_relative "../config/environment"
require "rails/test_help"
require "simplecov"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    SimpleCov.start
  end
end
