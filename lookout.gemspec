# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'lookout/version'

Lookout::Version.manifest.specification do |s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/lookout'

  s.description = IO.read(File.expand_path('../README', __FILE__))
  s.summary = s.description[/^  [[:alpha:]]+.*?\./]

  s.add_development_dependency 'yard', '~> 0.6.0'
end
