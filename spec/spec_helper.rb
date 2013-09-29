require 'rubygems'
require 'bundler/setup'
require 'rspec'

require './lib/versacommerce_api/'

RSpec.configure do |c|
  c.mock_with :rspec
end