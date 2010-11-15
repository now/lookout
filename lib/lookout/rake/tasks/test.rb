# -*- coding: utf-8 -*-

require 'rake'
require 'rake/tasklib'

module Lookout module Rake module Tasks end end end

class Lookout::Rake::Tasks::Test < Rake::TaskLib
  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')

  def initialize(specification = nil, name = :test)
    self.specification, @name = specification, name
    yield self if block_given?
    define
  end

  def define
    desc @name == :test ? 'Run tests' : 'Run tests for %s' % @name
    task @name do
      ruby '-w %s -- "%s" %s' % [options, LoaderPath, arguments]
    end
  end

  attr_accessor :requires

private

  def specification=(specification)
    @paths, @requires = ['lib'], []
    if not specification and Object.const_defined? :Gem
      gemspec = Dir['*.gemspec'].first and
        specification = Gem::Specification.load(gemspec)
    end
    @paths, @requires = specification.require_paths, specification.name
  end

  def options
    @paths.map{ |p| '-I%s' % p }.join(' ')
  end

  def arguments
    requires.map{ |r| '-r%s' % r }.concat(files).join(' ')
  end

  def files
    return FileList[ENV['TEST']] if ENV['TEST']
    FileList['test/**/*.rb'].map{ |f| '"%s"' % f }
  end
end
