# frozen_string_literal: true

# $bundle exec ruby rack_examples/lambda.rb

status = 200
headers = { 'content-type' => 'text/html' }
body = ['Hello world!']

application = lambda do
  [status, headers, body]
end

puts application.call
