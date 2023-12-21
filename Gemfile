# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "puma", "~> 6.4"
gem "rack"
gem "rackup", "~> 2.1"

group :development do
  gem "pry", "~> 0.14.2"
end

group :test do
  gem "minitest", "~> 5.20"
  gem "minitest-reporters", "~> 1.6"
  gem "rack-test", "~> 2.1"
  gem "rubocop", "~> 1.58"
end
