# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skyblue/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "skyblue-rails"
  spec.version       = Skyblue::Rails::VERSION
  spec.authors       = ["zmpeg"]
  spec.email         = ["zandstra.matt@gmail.com"]

  spec.summary       = "SkyBlue CSS with rails 4+"
  spec.description   = "This gem provides SkyBlue CSS Framework assets for rails 4+."
  spec.homepage      = 'https://github.com/zmpeg/skyblue-rails'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", [">= 3.1.0"]
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
