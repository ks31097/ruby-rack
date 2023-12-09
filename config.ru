# frozen_string_literal: true

require_relative 'ruby_rack'

map '/hello' do
  run Action::Hello.new
end

use Action::Middleware
run Action::Application.new
