# -*- coding: utf-8 -*-

require 'rubygems'
require 'rubygems/builder'
require 'rubygems/dependency_installer'
require 'rubygems/installer'

class Lookout::Rake::Tasks::Gem < Rake::TaskLib
  def initialize(specification = Lookout::Rake::Tasks.specification)
    specification or
      raise ArgumentError,
        'gem specification was not given and could not be found in project root: %s' %
          Lookout::Rake::Tasks.top_srcdir
    @specification = specification
    yield self if block_given?
    define
  end

  def define
    desc 'Build %s' % specification.file_name
    task :build => specification.file_name
    file specification.file_name => specification.files do
      when_writing('Building %s' % specification.file_name) do
        Gem::Builder.new(specification).build
      end
    end

    desc 'Check %s' % specification.file_name
    task :check => :build do
      checkdir = specification.full_name
      Gem::Installer.new(specification.file_name).unpack checkdir
      sh 'rake --rakefile %s/Rakefile -s test' % checkdir
      rm_r checkdir
    end

    desc 'Install %s and its dependencies' % specification.file_name
    task :install do
      Gem::DependencyInstaller.new.install specification.file_name
    end
  end

  attr_reader :specification
end
