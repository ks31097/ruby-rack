# frozen_string_literal: true

require 'pry'
require 'rack/response'
# $ curl -iv http://localhost:9292

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
    def call(env)
      puts inspect_env(env)
      Rack::Response.new('The Rack Env').finish
      # response = Rack::Response.new
      # response.write 'Hello'
      # response.finish
    end

    def inspect_env(env)
      puts format('Request headers', request_headers(env))
      puts format('Server info', server_info(env))
      puts format('Rack info', rack_info(env))
    end

    def request_headers(env)
      env.select { |key, value| key.include?('HTTP_') }
    end

    def server_info(env)
      env.reject { |key, value| key.include?('HTTP_') or key.include?('rack.') }
    end

    def rack_info(env)
      env.select { |key, value| key.include?('rack.') }
    end

    def format(heading, pairs)
      [heading, '', format_pairs(pairs), "\n"].join("\n")
    end

    def format_pairs(pairs)
      pairs.map { |key, value| " #{[key, value.inspect].join(': ')}" }
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
end
