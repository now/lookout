# -*- coding: utf-8 -*-

require 'inventory-rake-1.0'

load File.expand_path('../lib/lookout-3.0/version.rb', __FILE__)

Inventory::Rake::Tasks.define Lookout::Version

Inventory::Rake::Tasks.unless_installing_dependencies do
  require 'lookout-rake-3.0'
  Lookout::Rake::Tasks::Test.new do |t|
    ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'] = ''
  end

  require 'inventory-rake-tasks-yard-1.0'
  Inventory::Rake::Tasks::YARD.new do |t|
    t.options += %w'--plugin yard-heuristics-1.0 --plugin yard-value-1.0'
    t.globals[:source_code_url] = 'https://github.com/now/%s/blob/v%s/%%s#L%%d' % [t.inventory.package, t.inventory]
  end
end
