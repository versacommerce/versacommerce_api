# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'versacommerce_api/version'

Gem::Specification.new do |spec|
  spec.name          = "versacommerce_api"
  spec.version       = VersacommerceAPI::VERSION
  spec.author        = ["VersaCommerce"]

  s.summary          = %q{The VersaCommerce API gem is a lightweight gem for accessing the VersaCommerce admin REST web services}
  s.description      = %q{The VersaCommerce API gem allows Ruby developers to programmatically access the admin section of VersaCommerce shops. The API is implemented as JSON or XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation.}
  spec.homepage      = "http://www.versacommerce.de"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  s.add_dependency("activeresource", [">= 3.0.0"])
  s.add_dependency("thor", [">= 0.14.4"])

  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency("mocha", ">= 0.9.8")
    s.add_development_dependency("fakeweb")
  else
    s.add_dependency("mocha", ">= 0.9.8")
    s.add_dependency("fakeweb")
  end
end
