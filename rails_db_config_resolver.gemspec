# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_db_config_resolver/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_db_config_resolver'
  spec.version       = RailsDbConfigResolver::VERSION
  spec.authors       = ['Cameron Martin']
  spec.email         = ['cameronmartin123@gmail.com']
  spec.summary       = %q{Rails db configuration, outside of rails}
  spec.description   = %q{Use the database configuration from a rails app, without using rails}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'

  spec.add_dependency 'rattributes'
end
