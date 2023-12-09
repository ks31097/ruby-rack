# frozen_string_literal: true

status = 200
headers = { 'content-type' => 'text/html' }
body = ['Hello world!']

application = lambda do
  [status, headers, body]
end

puts application.call
