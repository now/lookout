# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Test
  include Rake::DSL

  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')
  Paths = %w'lib'

  def initialize(options = {})
    self.name = options.fetch(:name, :test)
    self.paths = options.fetch(:paths, Paths)
    self.requires = options.fetch(:requires, [])
    self.files = options.fetch(:files){ ENV.include?('TEST') ? FileList[ENV['TEST']] : nil }
    inventory = options[:inventory] ||
      (tasks = feature?('Inventory::Rake::Tasks') and tasks.inventory) and
      self.inventory = inventory
    self.specification = options.fetch(:specification) if options.include? :specification
    yield self if block_given?
    define
  end

  attr_accessor :name
  attr_writer :paths, :requires, :files

  def paths
    return @paths if @paths and not @paths.equal? Paths
    self.specification = specification
    @paths
  end

  def requires
    return @requires unless @requires.empty?
    self.specification = specification
    @requires
  end

  def files
    @files ||= FileList['test/unit/**/*.rb']
  end

  def inventory=(inventory)
    self.paths = inventory.lib_directories
    self.requires = [inventory.package_require]
    @files ||= inventory.unit_test_files
    inventory
  end

  def specification
    return @specification if defined? @specification
    return nil unless defined? ::Gem
    gemspec = Dir['*.gemspec'].first
    fail 'gem specification was not given and could not be found in project root: %s' %
      Dir.pwd unless gemspec
    @specification = Gem::Specification.load(gemspec)
  end

  def specification=(specification)
    self.paths = specification.require_paths
    self.requires = [specification.name.gsub('-', '/')]
    specification
  end

  def define
    desc @name == :test ? 'Run tests' : 'Run tests for %s' % @name
    task @name do
      run
    end

    desc @name == :test ? 'Check test coverage' : 'Check test coverage for %s' % @name
    task :"#{@name}:coverage" do
      run %w'-c'
    end

    task :default => @name unless Rake::Task.task_defined? :default

    task :check => :test if @name == :test
  end

  private

  def run(additional = [])
    ruby '-w %s -- %s %s' % [options, escape(LoaderPath), arguments(additional)]
  end

  def options
    paths.uniq.map{ |p| '-I%s' % p }.join(' ')
  end

  def arguments(additional)
    requires.uniq.map{ |r| '-r%s' % r }.
      concat(line).concat(additional).
      push('--').
      concat(tests).join(' ')
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

  def feature?(path)
    const = path.split('::').reduce(Object){ |o, e| begin o.const_get(e); rescue NameError; return nil; end }
    const.name == path ? const : nil
  end
end
