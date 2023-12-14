# frozen_string_literal: true

require './helper_module'
require './request_helper'
require 'pry'
require 'rack/response'

# $ curl -iv http://localhost:9292
# $ curl -iv http://localhost:9292/the_rack_env
# $ curl -iv http://localhost:9292/request_path

module Action
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      # Before hook
      # Update env variable
      p "Start - #{Time.now}"
      responce = @app.call(env)
      # After hook
      p "End - #{Time.now}"

      responce
    end
  end

  class TheRackEnv
    include HelperModule

    def call(env)
      puts inspect_env(env)
      Rack::Response.new('The Rack Env').finish
    end

    def inspect_env(env)
      puts format('Request headers', request_headers(env))
      puts format('Server info', server_info(env))
      puts format('Rack info', rack_info(env))
    end
  end

  class Application
    def call(env)
      [
        200,
        { 'content-type' => 'text/html' },
        ['<html><body><h1>Hello, world!</h1></body></html>']
      ]
    end
  end

  class RequestInfo
    include RequestHelper

    def call(env)
      handle_request(env['REQUEST_METHOD'], env['REQUEST_PATH'])
    end
  end
end
