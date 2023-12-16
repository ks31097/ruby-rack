# frozen_string_literal: true

require 'pry'
require 'rack/response'
require 'rack/server'

class Greeting
  def response
    [200, { 'content-type' => 'text/html' }, ['Hello user!']]
  end
end

class GreetingApp
  def self.call(env)
    Greeting.new.response
  end
end

# $curl -iv http://localhost:9292?message

class RackEnvApp
  def self.call(env)
    Rack::Response.new("Hello World. You said: #{env['QUERY_STRING']}").finish
  end
end

class RackEnvInspector
  def self.call(env)
    [200, {}, [env.inspect]]
  end
end

# Start Rack::Server
# $bundle exec ruby rack_app.rb
# Rack::Server.start app => GreetingApp

# Rack::Server.start app: RackEnvApp
Rack::Server.start app: RackEnvInspector
