# frozen_string_literal: true

# config.ru
# $curl -iv http://localhost:9292/

class App
  def call(env)
    [200, { 'content-type' => 'text/html' }, ['Hello, Rack!']]
  end
end

class RackMiddleware
  def initialize(app, who = 'no one')
    @app = app
    @who = who
  end

  def call(env)
    status, headers, body = @app.call(env)
    body << "<br/>Powered by #{@who}!"
    [status, headers, body]
  end
end

app = App.new
use RackMiddleware, "It's me"
run app
