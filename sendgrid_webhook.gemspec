# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid_webhook/version'

Gem::Specification.new do |spec|
  spec.name          = "sendgrid_webhook"
  spec.version       = SendgridWebhook::VERSION
  spec.authors       = ["ilake"]
  spec.email         = ["lake.ilakela+github@gmail.com"]
  spec.summary       = "Templates for tracking sendgrid email state webhook"
  spec.description   = "Template sfor tracking sendgrid email state webhook"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sendgrid"
end
