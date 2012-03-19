# -*- coding: utf-8 -*-

require 'inventory'

module Lookout
  Version = Inventory.new(3, 0, 0){
    def requires
      %w'
        stringio
      '
    end

    def libs
      %w'
        lookout/object.rb
        lookout/aphonic.rb
        lookout/actual.rb
        lookout/actual/method.rb
        lookout/actual/not.rb
        lookout/actual/not/method.rb
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
        lookout/difference.rb
        lookout/difference/object.rb
        lookout/difference/array.rb
        lookout/difference/exception.rb
        lookout/difference/hash.rb
        lookout/difference/range.rb
        lookout/difference/lookout.rb
        lookout/difference/lookout/actual.rb
        lookout/difference/lookout/actual/method.rb
        lookout/difference/lookout/actual/not.rb
        lookout/difference/lookout/actual/not/method.rb
        lookout/difference/lookout/output.rb
        lookout/difference/lookout/reception.rb
        lookout/difference/lookout/warning.rb
        lookout/difference/module.rb
        lookout/difference/regexp.rb
        lookout/difference/string.rb
        lookout/difference/symbol.rb
        lookout/encode.rb
        lookout/exception.rb
        lookout/exception/backtrace.rb
        lookout/exception/unknown.rb
        lookout/expect.rb
        lookout/expect/object.rb
        lookout/expect/object/context.rb
        lookout/expect/object/context/stub.rb
        lookout/expect/classes.rb
        lookout/expect/classes/exception.rb
        lookout/expect/exception.rb
        lookout/expect/lookout.rb
        lookout/expect/lookout/output.rb
        lookout/expect/lookout/reception.rb
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
        lookout/expected/lookout/actual.rb
        lookout/expected/lookout/actual/method.rb
        lookout/expected/lookout/actual/not.rb
        lookout/expected/lookout/actual/not/method.rb
        lookout/expected/lookout/output.rb
        lookout/expected/lookout/reception.rb
        lookout/expected/lookout/warning.rb
        lookout/expected/module.rb
        lookout/expected/range.rb
        lookout/expected/regexp.rb
        lookout/expected/string.rb
        lookout/expected/symbol.rb
        lookout/expected/trueclass.rb
        lookout/expectations.rb
        lookout/expectations/context.rb
        lookout/inspect.rb
        lookout/inspect/actual.rb
        lookout/inspect/argument.rb
        lookout/inspect/expected.rb
        lookout/literal.rb
        lookout/output.rb
        lookout/reception.rb
        lookout/stub.rb
        lookout/stub/method.rb
        lookout/stub/method/defined.rb
        lookout/stub/method/defined/definition.rb
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
        lookout/mock/method/defined.rb
        lookout/mock/method/undefined.rb
        lookout/mock/methods.rb
        lookout/mock/object.rb
        lookout/object/not.rb
        lookout/object/not/receive.rb
        lookout/object/to.rb
        lookout/object/to/receive.rb
        lookout/result.rb
        lookout/results.rb
        lookout/results/error.rb
        lookout/results/failure.rb
        lookout/results/success.rb
        lookout/warning.rb
      '
    end

    def additional_libs
      super +
        %w'
          lookout/rake/tasks.rb
          lookout/rake/tasks/test.rb
          lookout/rake/tasks/test/loader.rb
        '
    end

    def unit_tests
      super - %w'
        lookout/rake/tasks/test/loader.rb
      '
    end

    def additional_unit_tests
      %w'
        examples.rb
      '
    end
  }
end
