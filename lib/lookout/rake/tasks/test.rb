# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Test < Rake::TaskLib
  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')

  def initialize(options = {})
    @name = options.fetch(:name, :test)
    self.manifest = options[:manifest] if options.include? :manifest
    self.specification = options.fetch(:specification, Lookout::Rake::Tasks.specification)
    yield self if block_given?
    define
  end

  def define
    desc @name == :test ? 'Run tests' : 'Run tests for %s' % @name
    task @name do
      ruby '-w %s -- %s %s' % [options, escape(LoaderPath), arguments]
    end

    task :default => @name unless Rake::Task.task_defined? :default
  end

  attr_accessor :requires
  attr_accessor :files

  def manifest=(manifest)
    @paths = manifest.lib_directories
    @requires << manifest.package
    @files = manifest.unit_test_files
  end

  private

  def specification=(specification)
    @paths, @requires = specification ?
      [specification.require_paths, [specification.name]] :
      [['lib'], []]
  end

  def options
    @paths.uniq.map{ |p| '-I%s' % p }.join(' ')
  end

  def arguments
    requires.uniq.map{ |r| '-r%s' % r }.concat(line).push('--').concat(tests).join(' ')
  end

  def line
    return [] unless ENV['LINE'] and not ENV['LINE'].empty?
    ['-l%d' % ENV['LINE'].to_i]
  end

  def tests
    (files or FileList[ENV.fetch('TEST', 'test/unit/**/*.rb')]).map{ |f| escape(f) }
  end

  def escape(path)
    path.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/n, '\\\\\\1').gsub(/\n/, "'\n'")
  end
end
