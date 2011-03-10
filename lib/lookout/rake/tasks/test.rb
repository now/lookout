# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Test < Rake::TaskLib
  LoaderPath = File.join(File.dirname(__FILE__), 'test/loader.rb')

  def initialize(specification = Lookout::Rake::Tasks.specification, name = :test)
    self.specification, @name = specification, name
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

private

  def specification=(specification)
    @paths, @requires = specification ?
      [specification.require_paths, [specification.name]] :
      [['lib'], []]
  end

  def options
    @paths.map{ |p| '-I%s' % p }.join(' ')
  end

  def arguments
    requires.map{ |r| '-r%s' % r }.push('--').concat(files).join(' ')
  end

  def files
    FileList[ENV.fetch('TEST', 'test/unit/**/*.rb')].map{ |f| escape(f) }
  end

  def escape(path)
    path.gsub(/([^A-Za-z0-9_\-.,:\/@\n])/n, '\\\\\\1').gsub(/\n/, "'\n'")
  end
end
