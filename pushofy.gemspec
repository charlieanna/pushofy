# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushofy/version'

Gem::Specification.new do |spec|
  spec.name          = "pushofy"
  spec.version       = Pushofy::VERSION
  spec.authors       = ["Ankur Kothari"]
  spec.email         = ["ankothari@gmail.com"]
  spec.summary       = "Sending push notifications to Android and iOS devices."
  spec.description   = "Send push notifications to Android and iOS devices by maping the device unique id with their device token or registration id."
  spec.homepage      = "https://github.com/charlieanna/pushofy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'dotenv'

end
