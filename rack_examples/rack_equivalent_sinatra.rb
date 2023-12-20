# frozen_string_literal: true

require 'pry'
require 'rack/common_logger'
require 'rack/reloader'
require 'rack/server'

module SinatraApp
  class CustomHeader
    def initialize app
      @app = app
    end

    def call(env)
      status, headers, body = @app.call env
      #binding.pry
      [status, headers.merge({ 'My-Custom-Header' => 'User custom header' }), body]
    end
  end

  class AppAuthor
    def initialize app, name = 'I'
      @app = app
      @author = name
    end

    def call(env)
      status, headers, body = @app.call(env)
      body << "<br>This app was created by #{@author}"

      [status, headers, body]
    end
  end

  class Middleware
    def initialize app
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      headers['X-Custom-Header'] = Time.now.to_s

      [status, headers, body]
    end
  end

  class Application
    def self.call(env)
      headers = { 'content-type' => 'text/html' }
      if env['PATH_INFO'] == '/'
        status = 200
        body = 'Hi!'
      else
        status = 404
        body = "Sinatra doesn't know this ditty!"
      end

      [status, headers, [body]]
    end
  end
end

sinatra_app = Rack::Builder.new do
  use Rack::Reloader
  use Rack::CommonLogger
  use SinatraApp::CustomHeader
  use SinatraApp::Middleware
  use SinatraApp::AppAuthor, "Kostya"
  run SinatraApp::Application
end

Rack::Server.start app: sinatra_app
