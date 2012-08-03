# -*- coding: utf-8 -*-

require 'inventory-1.0'

module Lookout
  Version = Inventory.new(3, 0, 0){
    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 3, 0
        development 'inventory-rake-tasks-yard', 1, 3, 0
        development 'lookout-rake', 3, 0, 0
        development 'yard', 0, 8, 0
        development 'yard-heuristics', 1, 1, 0
        development 'yard-value', 1, 2, 0

        runtime 'value', 1, 1, 0
      }
    end

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
        lookout/diff/slice.rb
        lookout/diff/algorithms.rb
        lookout/diff/algorithms/difflib.rb
        lookout/diff/algorithms/difflib/position.rb
        lookout/diff/algorithms/difflib/position/new.rb
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
        lookout/diff/operations/copy.rb
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
        lookout/expect/classes.rb
        lookout/expect/classes/exception.rb
        lookout/expect/exception.rb
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
        lookout/inspect/argument.rb
        lookout/interfaces.rb
        lookout/interfaces/commandline.rb
        lookout/literal.rb
        lookout/stub.rb
        lookout/mock.rb
        lookout/output.rb
        lookout/plugins.rb
        lookout/reception.rb
        lookout/reception/arguments.rb
        lookout/reception/arguments/any.rb
        lookout/reception/arguments/error.rb
        lookout/reception/arguments/list.rb
        lookout/reception/arguments/none.rb
        lookout/reception/error.rb
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

    def additional_unit_tests
      %w'
        examples.rb
      '
    end
  }
end
