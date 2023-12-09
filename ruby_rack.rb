# frozen_string_literal: true

# $ curl -iv http://localhost:9292

class Application
  def initialize(status, headers, body)
    @status = status
    @headers = headers
    @body = body
  end

  def call(env)
    [@status, @headers, @body]
  end
end
