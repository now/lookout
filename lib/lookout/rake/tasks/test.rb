# -*- coding: utf-8 -*-

require 'rake'
require 'rake/tasklib'

module Lookout module Rake module Tasks end end end

class Lookout::Rake::Tasks::Test < Rake::TaskLib
  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')

  def initialize(specification = nil, name = :test)
    @name = name
    @paths = specification ? [specification.require_paths] : ['lib']
    @requires = specification ? [specification.name] : []
    yield self if block_given?
    define
  end

  def define
    desc @name == :test ? 'Run tests' : 'Run tests for %s' % @name
    task @name do
      ruby '-w %s -- "%s" %s %s' % [@paths.map{ |p| '-I%s' % p }.join(' '), LoaderPath, reqs, files.join(' ')]
    end
  end

  attr_accessor :requires

private

  def files
    return FileList[ENV['TEST']] if ENV['TEST']
    FileList['test/**/*.rb'].map{ |f| '"%s"' % f }
  end

  def reqs
    requires.map{ |r| '-r%s' % r }.join(' ')
  end
end
