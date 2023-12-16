# frozen_string_literal: true

require_relative 'app/controllers/application_controller'
require 'rack/reloader'

use Rack::Reloader, 0
use Action::Middleware

map '/request_path' do
  run Action::RequestInfo.new
end

map '/the_rack_env' do
  run Action::TheRackEnv.new
end

run Action::Application.new
