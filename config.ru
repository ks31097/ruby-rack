# frozen_string_literal: true

require_relative 'ruby_rack'

use Middleware
run Application.new
