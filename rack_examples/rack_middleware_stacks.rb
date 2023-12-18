# frozen_string_literal: true

require 'rack/conditional_get'
require 'rack/deflater'
require 'rack/etag'
require 'rack/server'
require 'rack/reloader'
require 'rack/common_logger'

class HelloWorldApp
  def self.call(env)
    [200, { 'content-type': 'application/html' }, ['Say Hello!']]
  end
end

class JsonResponse
  def initialize(app)
    @app = app
  end

  # Set the 'Accept' header to 'application/json'
  def call(env)
    env['HTTP_ACCEPT'] = 'application/json'
    @app.call env
  end
end

class Timer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call env
    headers['X-Custom-Header'] = Time.now.to_s

    [status, headers, body]
  end
end

# Rack::Builder creates a middleware stack
# The code inside config.ru is evaluated and built using a Rack::Builder
# which generates an rack API compliant object.

# Using Middleeware, you can add manipulate incoming data before hitting
# the next one or modify the response from an existing one.

# $curl -i http://localhost:9292/ \ -H "Accept: application/json"

program = Rack::Builder.new do
  use Timer
  use Rack::ETag # Add an ETag
  use Rack::ConditionalGet # Support Caching
  use Rack::Deflater # GZip
  use JsonResponse
  use Rack::Reloader
  use Rack::CommonLogger
  run HelloWorldApp # 'Say Hello!'
end

Rack::Server.start app: program
