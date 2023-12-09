# frozen_string_literal: true

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
