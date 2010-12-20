# -*- coding: utf-8 -*-

require 'rake'
require 'rake/tasklib'

module Lookout module Rake end end

module Lookout::Rake::Tasks
  autoload :Gem, 'lookout/rake/tasks/gem'
  autoload :Test, 'lookout/rake/tasks/test'

  def self.top_srcdir
    @top_srcdir ||= Dir.pwd
  end

  def self.specification
    return @specification if defined? @specification
    return nil unless Object.const_defined? :Gem
    return nil unless gemspec = Dir['%s/*.gemspec' % top_srcdir].first
    @specification = ::Gem::Specification.load(gemspec)
  end
end
