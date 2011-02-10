# -*- coding: utf-8 -*-

require 'rake'
require 'rake/tasklib'

module Lookout module Rake end end

module Lookout::Rake::Tasks
  autoload :Gem, 'lookout/rake/tasks/gem'
  autoload :Tags, 'lookout/rake/tasks/tags'
  autoload :Test, 'lookout/rake/tasks/test'

  class << self
    def top_srcdir
      @top_srcdir ||= Dir.pwd
    end

    def gemspec
      @gemspec ||= Dir['%s/*.gemspec' % top_srcdir].first
    end

    def specification
      return @specification if defined? @specification
      return nil unless defined? ::Gem::Specification
      return nil unless gemspec
      @specification = ::Gem::Specification.load(gemspec)
    end

    def specification!
      specification or
        raise ArgumentError,
          'gem specification was not given and could not be found in project root: %s' %
            top_srcdir
    end
  end
end
