# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Test < Rake::TaskLib
  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')
  Paths = %w'lib'

  def initialize(options = {})
    self.name = options.fetch(:name, :test)
    self.paths = options.fetch(:paths, Paths)
    self.requires = options.fetch(:requires, [])
    self.files = options.fetch(:files){ ENV.include?('TEST') ? FileList[ENV['TEST']] : nil }
    manifest = options[:manifest] || Lookout::Rake::Tasks.manifest and self.manifest = manifest
    self.specification = options.fetch(:specification) if options.include? :specification
    yield self if block_given?
    define
  end

  attr_accessor :name
  attr_writer :paths, :requires, :files

  def paths
    return @paths if @paths
    self.specification = Lookout::Rake::Tasks.specification
  end

  def requires
    return @requires unless @requires.empty?
    self.specification = Lookout::Rake::Tasks.specification
  end

  def files
    @files ||= FileList['test/unit/**/*.rb']
  end

  def manifest=(manifest)
    self.paths = manifest.lib_directories
    self.requires = [manifest.package_require]
    @files ||= manifest.unit_test_files
  end

  def specification=(specification)
    self.paths = specification.require_paths
    self.requires = [specification.name.gsub('-', '/')]
  end

  def define
    desc @name == :test ? 'Run tests' : 'Run tests for %s' % @name
    task @name do
      ruby '-w %s -- %s %s' % [options, escape(LoaderPath), arguments]
    end

    task :default => @name unless Rake::Task.task_defined? :default
  end

  def options
    paths.uniq.map{ |p| '-I%s' % p }.join(' ')
  end

  def arguments
    requires.uniq.map{ |r| '-r%s' % r }.concat(line).push('--').concat(tests).join(' ')
  end

  def line
    return [] unless ENV['LINE'] and not ENV['LINE'].empty?
    ['-l%d' % ENV['LINE'].to_i]
  end

  def tests
    files.map{ |e| escape(e) }
  end

  def escape(path)
    path.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/n, '\\\\\\1').gsub(/\n/, "'\n'")
  end
end
