# frozen_string_literal: true

# bundle exec ruby rack_test/rack_test.rb


require 'minitest/autorun'
require 'rack/test'
require "minitest/reporters"
Minitest::Reporters.use!

class HelloWorldApp
  def self.call env
    [
      200,
      { 'content-type' => 'text/plain' },
      ['Hello world!']
    ]
  end
end

class HelloWorldAppTest < Minitest::Test

  # Include methods to use in the test case
  include Rack::Test::Methods

  def app
    # Define the rack compatible object to make “requests” too
    HelloWorldApp
  end

  def test_return_hello_world
    get '/'

    # Make a get request to /, response is stored in last_response
    assert last_response.ok?
    assert_equal 'Hello world!', last_response.body
    assert_equal 'text/plain', last_response.content_type
  end
end
