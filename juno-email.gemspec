# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juno/version'

Gem::Specification.new do |spec|
  spec.name          = 'juno-email'
  spec.version       = Juno::VERSION
  spec.authors       = ['Jonathan Hinkle']
  spec.email         = ['hello@hynkle.com']
  spec.summary       = %q{convert mail from the Juno email client to mbox format}
  spec.homepage      = 'https://github.com/hynkle/juno-email'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'slop'
  spec.add_dependency 'inifile'
  spec.add_dependency 'ruby-ole'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
end
