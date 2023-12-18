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

class RackRequest
  def self.call(env)
    request = Rack::Request.new env
    request.params # contains the union of GET and POST params
    request.xhr? # request with AJAX
    request.body # the incoming request IO stream

    if request.params['message']
      [200, {}, [request.params['message']]]
    else
      [400, {}, ['Say something to me!']]
    end
  end
end

class RackResponse
  def self.call(env)
    response = Rack::Response.new
    response.write 'Hello World!' # write some content to the body
    # response.body = ['Hello World!'] # or set it directly
    response['X-Custom-Header'] = 'foo'
    response.set_cookie 'bar', 'baz'
    response.status = 202

    response.finish # return the generated triplet
  end
end

# Start Rack::Server
# $bundle exec ruby rack_app.rb

# Rack::Server.start app => GreetingApp

# http://localhost:9292?message=foo
# Rack::Server.start app: RackEnvApp

# Rack::Server.start app: RackEnvInspector

# curl -ivX POST http://localhost:9292?message=text`
# Rack::Server.start app: RackRequest

Rack::Server.start app: RackResponse
