# -*- coding: utf-8 -*-

class Lookout::Manifest
  class << self
    def attach(container, version = :Version)
      (class << container.const_get(version); self; end).instance_exec(new(container, version)) do |manifest|
        define_method :manifest do
          manifest
        end
      end
    end
  end

  def initialize(container, version)
    @container, @version = container, version
  end

  def specification
    @specification ||= Gem::Specification.new do |s|
      s.name = package
      s.version = @container.const_get(@version)

      s.files = self

      yield s
    end
  end

  def package
    @container.name.split('::').join('-').downcase
  end

  def package_require
    package.gsub('-', '/')
  end

  def version_constant
    '%s::%s' % [@container, @version]
  end

  def version_require
    File.join(package, 'version')
  end

  def lib_directories
    %w'lib'
  end

  def load(relative_to)
    requires.each do |requirement|
      require requirement
    end
    loads.each do |load|
      Kernel.load File.expand_path((['..'] * @container.name.split('::').length).push(load).join('/'), relative_to)
    end
  end

  def requires
    []
  end

  def loads
    libs
  end

  def libs
    []
  end

  def additional_libs
    []
  end

  def all_libs
    libs + additional_libs
  end

  def lib_files
    all_libs.map{ |e| 'lib/%s' % e }
  end

  def unit_tests
    all_libs
  end

  def additional_unit_tests
    []
  end

  def all_unit_tests
    unit_tests + additional_unit_tests
  end

  def unit_test_files
    all_unit_tests.map{ |e| 'test/unit/%s' % e }
  end

  def test_files
    unit_test_files
  end

  def additional_files
    %w'
      README
      Rakefile
    '
  end

  def files
    lib_files + test_files + additional_files
  end

  def to_a
    files
  end
end
