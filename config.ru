# frozen_string_literal: true

require_relative 'ruby_rack'

run Application.new(
  200,
  { 'content-type' => 'text/html' },
  ['<html><body><h1>Hello world!</h1></body></html>']
)
