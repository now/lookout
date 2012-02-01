# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Gem < Rake::TaskLib
  def initialize(specification = Lookout::Rake::Tasks.specification!)
    @specification = specification
    yield self if block_given?
    define
  end

  def define
    desc 'Build %s' % specification.file_name
    task :build => specification.file_name
    file specification.file_name => [specification.loaded_from] + specification.files do
      when_writing 'Building %s' % specification.file_name do
        require 'rubygems' unless defined? Gem
        require 'rubygems/installer' unless defined? Gem::Builder
        Gem::Builder.new(specification).build
      end
    end

    desc 'Check %s' % specification.file_name
    task :check => :build do
      require 'rubygems' unless defined? Gem
      require 'rubygems/installer' unless defined? Gem::Installer
      checkdir = File.join(Lookout::Rake::Tasks.top_srcdir, specification.full_name)
      Gem::Installer.new(specification.file_name, :unpack => true).unpack checkdir
      sh 'rake --rakefile %s/Rakefile -s test' % checkdir
      rm_r checkdir
    end

    desc 'Install %s and its dependencies' % specification.file_name
    task :install do
      require 'rubygems' unless defined? Gem
      require 'rubygems/dependency_installer' unless defined? Gem::DependencyInstaller
      Gem::DependencyInstaller.new.install specification.file_name
    end

    desc 'Push %s to rubygems.org' % specification.file_name
    task :push => :check do
      sh 'gem push -%s-verbose %s' % [verbose ? '' : '-no', specification.file_name]
    end
  end

  attr_reader :specification
end
