# -*- coding: utf-8 -*-

require 'inventory/rake/tasks'

$:.unshift File.expand_path('../lib', __FILE__)
require 'lookout/rake/tasks'
require 'lookout/version'

Inventory::Rake::Tasks.define Lookout::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/lookout'

  s.add_development_dependency 'yard', '~> 0.7.0'

  s.add_runtime_dependency 'inventory', '~> 0.2.0'
}
Lookout::Rake::Tasks::Test.new do |t|
  ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'] = ''
end
