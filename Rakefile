# -*- coding: utf-8 -*-

$:.unshift File.expand_path("../lib", __FILE__)

require 'rake/gempackagetask'
require 'rake/testtask'
require 'rubygems/dependency_installer'
require 'yard'
require 'expectations/version'

task :default => :test

specification = Gem::Specification.new do |s|
  s.name   = 'nexpectations'
  s.summary = 'A lightweight unit testing framework.'
  s.version = Expectations::Version
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'http://github.com/now/nexpectations'
  s.description = <<EOD
nexpectations is a lightweight unit testing framework based on expectations by
Jay Fields. Tests (expectations) are written as follows
  expect 2 do
    1 + 1
  end

  expect(2) == 1 + 1

  expect 2.to.be == 1 + 1

  expect NoMethodError do
    Object.invalid_method_call
  end.
EOD

  s.files = FileList['{lib,test}/**/*.rb', '[A-Z]*$']

  s.add_runtime_dependency 'mocha', '>= 0.9.8'

  s.add_development_dependency 'yard', '>= 0.2.3.5'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*.rb'
end

YARD::Rake::YardocTask.new

Rake::GemPackageTask.new(specification) do |g|
  desc 'Run :package and install the resulting gem'
  task :install => :package do
    Gem::DependencyInstaller.new.install File.join(g.package_dir, g.gem_file)
  end
end

desc 'Generate README'
task :readme do
  %x[erb README_TEMPLATE > README]
end
