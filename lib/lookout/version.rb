# -*- coding: utf-8 -*-

module Lookout
  class Manifest
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

  Version = '2.4.0'

  Class.new(Manifest){
    def requires
      %w'
        stringio
      '
    end

    def libs
      %w'
        lookout/object.rb
        lookout/aphonic.rb
        lookout/diff.rb
        lookout/diff/range.rb
        lookout/diff/algorithms.rb
        lookout/diff/algorithms/difflib.rb
        lookout/diff/algorithms/difflib/position.rb
        lookout/diff/algorithms/difflib/position/to.rb
        lookout/diff/formats.rb
        lookout/diff/formats/inline.rb
        lookout/diff/formats/set.rb
        lookout/diff/formats/unified.rb
        lookout/diff/group.rb
        lookout/diff/groups.rb
        lookout/diff/match.rb
        lookout/diff/operation.rb
        lookout/diff/operations.rb
        lookout/diff/operations/delete.rb
        lookout/diff/operations/equal.rb
        lookout/diff/operations/insert.rb
        lookout/diff/operations/replace.rb
        lookout/encode.rb
        lookout/expect.rb
        lookout/expect/object.rb
        lookout/expect/object/context.rb
        lookout/expect/classes.rb
        lookout/expect/classes/exception.rb
        lookout/expect/exception.rb
        lookout/expect/lookout.rb
        lookout/expect/lookout/output.rb
        lookout/expect/lookout/reception.rb
        lookout/expect/lookout/state.rb
        lookout/expect/lookout/warning.rb
        lookout/expected.rb
        lookout/expected/object.rb
        lookout/expected/array.rb
        lookout/expected/classes.rb
        lookout/expected/classes/exception.rb
        lookout/expected/exception.rb
        lookout/expected/falseclass.rb
        lookout/expected/hash.rb
        lookout/expected/lookout.rb
        lookout/expected/lookout/output.rb
        lookout/expected/lookout/reception.rb
        lookout/expected/lookout/state.rb
        lookout/expected/lookout/warning.rb
        lookout/expected/module.rb
        lookout/expected/range.rb
        lookout/expected/regexp.rb
        lookout/expected/string.rb
        lookout/expected/trueclass.rb
        lookout/expectations.rb
        lookout/expectations/context.rb
        lookout/inspect.rb
        lookout/inspect/actual.rb
        lookout/inspect/argument.rb
        lookout/inspect/error.rb
        lookout/inspect/expected.rb
        lookout/output.rb
        lookout/reception.rb
        lookout/stub.rb
        lookout/stub/method.rb
        lookout/stub/method/defined.rb
        lookout/stub/method/undefined.rb
        lookout/stub/methods.rb
        lookout/stub/object.rb
        lookout/mock.rb
        lookout/mock/method.rb
        lookout/mock/method/arguments.rb
        lookout/mock/method/arguments/any.rb
        lookout/mock/method/arguments/list.rb
        lookout/mock/method/arguments/none.rb
        lookout/mock/method/calls.rb
        lookout/mock/method/calls/exactly.rb
        lookout/mock/method/calls/lower.rb
        lookout/mock/method/calls/upper.rb
        lookout/mock/method/defined.rb
        lookout/mock/method/undefined.rb
        lookout/mock/methods.rb
        lookout/mock/object.rb
        lookout/object/not.rb
        lookout/object/not/receive.rb
        lookout/object/to.rb
        lookout/object/to/receive.rb
        lookout/state.rb
        lookout/state/recording.rb
        lookout/state/verify.rb
        lookout/state/be.rb
        lookout/state/have.rb
        lookout/state/not.rb
        lookout/state/not/verify.rb
        lookout/state/not/be.rb
        lookout/state/not/have.rb
        lookout/result.rb
        lookout/results.rb
        lookout/results/error.rb
        lookout/results/error/exception.rb
        lookout/results/error/exception/backtrace.rb
        lookout/results/failure.rb
        lookout/results/success.rb
        lookout/warning.rb
      '
    end

    def additional_libs
      %w'
        lookout.rb
        lookout/rake/tasks.rb
        lookout/rake/tasks/gem.rb
        lookout/rake/tasks/tags.rb
        lookout/rake/tasks/test.rb
        lookout/rake/tasks/test/loader.rb
        lookout/version.rb
      '
    end

    # TODO: Add tests for these files as well.
    def unit_tests
      super - %w'
        lookout/rake/tasks.rb
        lookout/rake/tasks/gem.rb
        lookout/rake/tasks/tags.rb
        lookout/rake/tasks/test.rb
        lookout/rake/tasks/test/loader.rb
      '
    end

    def additional_unit_tests
      %w'
        examples.rb
      '
    end
  }.attach self
end
