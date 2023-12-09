# frozen_string_literal: true

# config.ru
# $ curl -iv http://localhost:9292

status = 200
headers = { 'content-type' => 'text/html' }
body = ['Hello world!']

application = lambda do |env|
  [status, headers, body]
end

run application
