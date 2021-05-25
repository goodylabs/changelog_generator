# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'changelog_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "changelog_generator"
  spec.version       = ChangelogGenerator::VERSION
  spec.authors       = ["Adam Niedzielski", "Grzegorz Błaszczyk"]
  spec.email         = ["adam.niedzielski@goodylabs.com", "grzegorz.blaszczyk@goodylabs.com"]
  spec.description   = %q{Description}
  spec.summary       = %q{Summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake"
end
