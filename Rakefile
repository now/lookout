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

class Yard
  include Rake::DSL

  def initialize(options = {})
    self.name = options.fetch(:name, :html)
    self.options = options.fetch(:options){ ENV.include?('OPTIONS') ? ENV['OPTIONS'] : %w'--no-private --markup markdown' }
    self.inventory = options.fetch(:inventory, Inventory::Rake::Tasks.inventory)
    self.files = options.fetch(:files){ ENV.include?('FILES') ? FileList[ENV['FILES']] : inventory.lib_files }
    yield self if block_given?
    define
  end

  attr_accessor :name, :options, :files, :inventory

  def define
    desc name == :html ?
      'Generate documentation in HTML format' :
      'Generate documentation for %s in HTML format' % name
    task name do
      require 'yard'
      Rake.rake_output_message 'yard doc %s' % arguments.join(' ') if verbose
      yardoc = YARD::CLI::Yardoc.new
      yardoc.parse_arguments(*arguments)
      yardoc.options[:files] = []
      yardoc.options[:readme] = nil
      yardoc.run(nil)
    end
  end

  private

  def arguments
    options.dup.push('--').concat(files)
  end
end
Yard.new
