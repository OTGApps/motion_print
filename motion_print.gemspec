# -*- encoding: utf-8 -*-

$:.push File.expand_path('../motion', __FILE__)
require 'motion_print/version'

Gem::Specification.new do |spec|
  spec.name          = 'motion_print'
  spec.version       = MotionPrint::VERSION
  spec.authors       = ['Mark Rickert']
  spec.email         = ['mjar81@gmail.com']
  spec.description   = 'motion_print is a RubyMotion friendly console logger and debugging tool.'
  spec.summary       = 'A RubyMotion pretty printer.'
  spec.homepage      = 'https://github.com/OTGApps/motion_print'
  spec.license       = 'MIT'

  files = []
  files << 'README.md'
  files << 'LICENSE'
  files.concat(Dir.glob('lib/**/*.rb'))
  files.concat(Dir.glob('motion/**/*.rb'))
  spec.files = files

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bacon'
  spec.add_development_dependency 'rake'
end
