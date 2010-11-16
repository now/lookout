# -*- coding: utf-8 -*-

require 'rake/gempackagetask'
require 'rubygems/dependency_installer'
require 'yard'

$:.unshift File.expand_path('../lib', __FILE__)

require 'lookout/rake/tasks/test'

spec = Gem::Specification.load(File.expand_path('../lookout.gemspec', __FILE__))

task :default => :test

Lookout::Rake::Tasks::Test.new do |t|
  ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'] = ''
end

YARD::Rake::YardocTask.new

Rake::GemPackageTask.new(spec) do |g|
  desc 'Run :package and install the resulting gem'
  task :install do
    Gem::DependencyInstaller.new.install File.join(g.package_dir, g.gem_file)
  end
end
