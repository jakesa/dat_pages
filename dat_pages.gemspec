# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dat_pages/version'

Gem::Specification.new do |spec|
  spec.name          = "dat_pages"
  spec.version       = DATPages::VERSION
  spec.authors       = ["Jake Sarate"]
  spec.email         = ["jake.sarate@dat.com"]

  spec.summary       = %q{Page object library for Appium}
  spec.description   = %q{Page object library for Appium}
  spec.homepage      = "https://github.com/jakesa/dat_pages"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'appium_lib'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'capybara', '~> 2.15.1'
  spec.add_dependency 'appium_capybara', '~>1.4.1'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'sinatra'
end
