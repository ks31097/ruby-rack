# frozen_string_literal: true

require_relative 'ruby_rack'

use Action::Middleware
run Action::Application.new
