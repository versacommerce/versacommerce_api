# -*- encoding : utf-8 -*-
$:.unshift File.dirname(__FILE__)

require 'active_resource'
require 'active_support/core_ext/class/attribute_accessors'
require 'digest/md5'
require 'base64'
require 'yaml'

module VersacommerceAPI
  # Your code goes here...
end

require "versacommerce_api/associatable"
require "versacommerce_api/version"
require 'versacommerce_api/countable'
require 'versacommerce_api/metafieldable'
require 'versacommerce_api/resources'
require 'versacommerce_api/session'
