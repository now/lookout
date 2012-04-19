# -*- coding: utf-8 -*-

# Rake task for running expectation tests.
class Lookout::Rake::Tasks::Test
  include Rake::DSL

  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')
  Paths = %w'lib'

  # Defines a Rake task for running expectation tests named _:name_.  Also
  # defines a task for running expectations with coverage name
  # _:name_:coverage.  If _:name_ `#==` `:test`, then the default task is set
  # to depend on it, unless the default task has already been defined, as well
  # as the `:check` task.
  #
  # Optionally yields the _task_ being created so that it may be adjusted
  # further before being defined.
  # @param [Hash] options
  # @option options [Symbol] :name (:test) The name of the task
  # @option options [Array<String>] :paths (['lib']) The paths to add to
  #   `$LOAD_PATH`
  # @option options [Array<String>] :requires ([]) The libraries to require
  # @option options [Array<String>] :files (FileList[ENV['TEST']]) The
  #   expectation files to load
  # @option options [Inventory] :inventory (Inventory::Rake::Tasks.inventory)
  #   The Inventory to look for :paths, :requires, and :files in, see
  #   {#inventory=} (the default is only used if `inventory/rake/tasks` has
  #   been required)
  # @option options [Gem::Specification] :specification The Gem specification
  #   to look for :paths and :requires in, see {#specification=}
  # @option options [Array<String>] :options (['-w']) The options to pass to
  #   ruby
  # @yield [?]
  # @yieldparam [Test] task
  def initialize(options = {})
    self.name = options.fetch(:name, :test)
    self.paths = options.fetch(:paths, Paths)
    self.requires = options.fetch(:requires, [])
    self.files = options.fetch(:files){ ENV.include?('TEST') ? FileList[ENV['TEST']] : nil }
    inventory = options[:inventory] ||
      (provided?('inventory/rake/tasks') and Inventory::Rake::Tasks.inventory) and
      self.inventory = inventory
    self.specification = options.fetch(:specification) if options.include? :specification
    self.options = options.fetch(:options, %w'-w')
    yield self if block_given?
    define
  end

  # @return [Symbol] The name of the task
  attr_reader :name

  # @param [Symbol] value
  # @return [Symbol] The new name of the task: _value_
  attr_writer :name

  # @return [Array<String>] The paths to add to `$LOAD_PATH`; may load
  #   {#specification}
  def paths
    return @paths if @paths and not @paths.equal? Paths
    self.specification = specification
    @paths
  end

  # @param [Array<String>] value
  # @return [Array<String>] The new paths to add to `$LOAD_PATH`: _value_
  attr_writer :paths

  # @return [Array<String>] The libraries to require; may load {#specification}
  def requires
    return @requires unless @requires.empty?
    self.specification = specification
    @requires
  end

  # @param [Array<String>] value
  # @return [Array<String>] The new libraries to require: _value_
  attr_writer :requires

  # @return [Array<String>] The expectation files to load; defaults to
  #   `FileList['test/unit/**/*.rb]`
  def files
    @files ||= FileList['test/unit/**/*.rb']
  end

  # @param [Array<String>] value
  # @return [Array<String>] The new expectation files to load: _value_
  attr_writer :files

  # @return [Inventory] The inventory to use
  attr_reader :inventory

  # @param [Inventory] inventory
  # @return [Inventory] The new inventory to use for {#paths}, {#requires}, and
  #   {#files}: _inventory_
  def inventory=(inventory)
    self.paths = inventory.lib_directories
    self.requires = [inventory.package_require]
    @files ||= inventory.unit_test_files
    inventory
  end

  # @return [Gem::Specification] The specification to use; will try to find one
  #   by looking for `*.gemspec` in the current directory
  # @raise [RuntimeError] If no specification has been set and one can’t be
  #   found in the current directory (the project root directory)
  def specification
    return @specification if defined? @specification
    return nil unless defined? ::Gem
    gemspec = Dir['*.gemspec'].first
    fail 'gem specification was not given and could not be found in project root: %s' %
      Dir.pwd unless gemspec
    @specification = Gem::Specification.load(gemspec)
  end

  # @param [Gem::Specification] specification
  # @return [Gem::Specification] The new specification to use for {#paths} and
  #   {#requires}: _specification_
  def specification=(specification)
    self.paths = specification.require_paths
    self.requires = [specification.name.gsub('-', '/')]
    specification
  end

  # @return [Array<String>] The options to pass to ruby
  attr_reader :options

  # @param [Array<String>] value
  # @return [Array<String>] The new options to pass to ruby: _value_
  attr_writer :options

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

  def run(arguments = [])
    ruby '%s -- %s %s' % [(options + paths.uniq.map{ |e| '-I%s' % e }).join(' '),
                          escape(LoaderPath),
                          requires.uniq.map{ |r| '-r%s' % r }.
                            concat(line).concat(arguments).
                            push('--').
                          concat(files.map{ |e| escape(e) }).join(' ')]
  end

  def line
    return [] unless ENV['LINE'] and not ENV['LINE'].empty?
    ['-l%d' % ENV['LINE'].to_i]
  end

  def escape(path)
    path.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/n, '\\\\\\1').gsub(/\n/, "'\n'")
  end

  def provided?(path)
    $LOADED_FEATURES.any?{ |e| e.end_with? path + File.extname(e) }
  end
end
