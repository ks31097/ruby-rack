# frozen_string_literal: true

require_relative 'ruby_rack'
require 'rack/reloader'

use Rack::Reloader, 0
use Action::Middleware

map '/the_rack_env' do
  run Action::TheRackEnv.new
end

run Action::Application.new
