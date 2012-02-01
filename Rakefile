# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'lookout/rake/tasks'
require 'lookout/version'

Lookout::Rake::Tasks::Test.new(:manifest => Lookout::Version.manifest) do |t|
  ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'] = ''
end
Lookout::Rake::Tasks::Gem.new
