# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)

require 'lookout/version'

Gem::Specification.new do |s|
  s.name = 'lookout'
  s.version = Lookout::Version

  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'http://github.com/now/lookout'

  s.summary = 'A lightweight unit testing framework based on expectations.'
  s.description = <<EOD
Lookout is a lightweight unit testing framework based on expectations by
Jay Fields. Tests (expectations) are written as follows
  expect 2 do
    1 + 1
  end

  expect 2.to.equal?(1 + 1)

  expect NoMethodError do
    Object.invalid_method_call
  end.
EOD

  s.files = FileList['{lib,test}/**/*.rb', '[A-Z]*$']

  s.add_development_dependency 'yard', '~> 0.6.0'
end
