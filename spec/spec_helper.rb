# -*- encoding : utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'pry'

require './lib/versacommerce_api/'

RSpec.configure do |c|
	c.mock_with :rspec
end


def initialize_session
	VersacommerceAPI::Session.setup(api_key: "xxxxx", secret: "xxxxx")
	token = "xxxxx" #VersacommerceAPI::Session.request_token("test-produkte.versacommerce.de")
	session = VersacommerceAPI::Session.new("xxxxx.versacommerce.de", token)
	VersacommerceAPI::Base.activate_session(session)
end