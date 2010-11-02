# -*- coding: utf-8 -*-

require 'rake/gempackagetask'
require 'rake/testtask'
require 'rubygems/dependency_installer'
require 'yard'

specification = Gem::Specification.load(File.join(File.dirname(__FILE__),
                                                  'lookout.gemspec'))

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.ruby_opts << '-w'
  t.pattern = 'test/**/*.rb'
  ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'] = ''
end

YARD::Rake::YardocTask.new

Rake::GemPackageTask.new(specification) do |g|
  desc 'Run :package and install the resulting gem'
  task :install => :package do
    Gem::DependencyInstaller.new.install File.join(g.package_dir, g.gem_file)
  end
end
