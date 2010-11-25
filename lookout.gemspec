# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)

require 'lookout/version'

Gem::Specification.new do |s|
  s.name = 'lookout'
  s.version = Lookout::Version

  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'http://github.com/now/lookout'

  s.description = IO.read(File.expand_path('../README', __FILE__))
  s.summary = s.description[/^[[:alpha:]]+.*?\./]

  s.files = Dir['{lib,test}/**/*.rb'] + %w[README Rakefile]

  s.add_development_dependency 'yard', '~> 0.6.0'
end
