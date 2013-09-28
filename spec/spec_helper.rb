require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'pry'

require './lib/versacommerce_api/'

RSpec.configure do |c|
	c.mock_with :rspec
end


def initialize_session
	VersacommerceAPI::Session.setup(api_key: "4e6d0a2be244cff731f88caaff45e6ea3d2f9221", secret: "afe883e32194fc464c029e73fe9f3674b6e4996e")
	token = "c26a0c74" #VersacommerceAPI::Session.request_token("test-produkte.versacommerce.de")
	session = VersacommerceAPI::Session.new("test-produkte.versacommerce.de", token)
	VersacommerceAPI::Base.activate_session(session)
end