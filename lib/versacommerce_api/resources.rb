# -*- encoding : utf-8 -*-
require 'versacommerce_api/resources/base'
Dir.glob "#{File.dirname(__FILE__)}/resources/*", &method(:require)
