# -*- coding: utf-8 -*-

module Lookout
  Version = '2.4.0'

  class << Version
    def content
      {
        :requires => %w'
          stringio
        ',
        :loads => %w'
          lookout/object.rb
          lookout/aphonic.rb
          lookout/diff.rb
          lookout/diff/range.rb
          lookout/diff/algorithms.rb
          lookout/diff/algorithms/difflib.rb
          lookout/diff/algorithms/difflib/position.rb
          lookout/diff/algorithms/difflib/position/to.rb
          lookout/diff/formats.rb
          lookout/diff/formats/hash.rb
          lookout/diff/formats/inline.rb
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
          lookout/expected.rb
          lookout/expected/object.rb
          lookout/expected/array.rb
          lookout/expected/classes.rb
          lookout/expected/classes/standarderror.rb
          lookout/expected/falseclass.rb
          lookout/expected/hash.rb
          lookout/expected/module.rb
          lookout/expected/range.rb
          lookout/expected/recorders.rb
          lookout/expected/recorders/reception.rb
          lookout/expected/recorders/state.rb
          lookout/expected/regexp.rb
          lookout/expected/output.rb
          lookout/expected/string.rb
          lookout/expected/standarderror.rb
          lookout/expected/trueclass.rb
          lookout/expected/warning.rb
          lookout/expectation.rb
          lookout/expectation/context.rb
          lookout/expectations.rb
          lookout/expectations/context.rb
          lookout/expectations/line.rb
          lookout/expectations/object.rb
          lookout/expectations/classes.rb
          lookout/expectations/classes/standarderror.rb
          lookout/expectations/output.rb
          lookout/expectations/recorders.rb
          lookout/expectations/recorders/reception.rb
          lookout/expectations/recorders/state.rb
          lookout/expectations/standarderror.rb
          lookout/expectations/warning.rb
          lookout/inspect.rb
          lookout/inspect/actual.rb
          lookout/inspect/argument.rb
          lookout/inspect/error.rb
          lookout/inspect/expected.rb
          lookout/output.rb
          lookout/stub.rb
          lookout/stub/method.rb
          lookout/stub/methods.rb
          lookout/stub/object.rb
          lookout/mock.rb
          lookout/mock/method.rb
          lookout/mock/method/arguments.rb
          lookout/mock/method/arguments/any.rb
          lookout/mock/method/arguments/anything.rb
          lookout/mock/method/arguments/list.rb
          lookout/mock/method/arguments/none.rb
          lookout/mock/method/calls.rb
          lookout/mock/method/calls/exactly.rb
          lookout/mock/method/calls/lower.rb
          lookout/mock/method/calls/upper.rb
          lookout/mock/methods.rb
          lookout/mock/object.rb
          lookout/object/not.rb
          lookout/object/not/receive.rb
          lookout/object/to.rb
          lookout/object/to/receive.rb
          lookout/recorder.rb
          lookout/recorder/tape.rb
          lookout/recorders.rb
          lookout/recorders/reception.rb
          lookout/recorders/reception/not.rb
          lookout/recorders/state.rb
          lookout/recorders/state/verify.rb
          lookout/recorders/state/be.rb
          lookout/recorders/state/have.rb
          lookout/recorders/state/not.rb
          lookout/recorders/state/not/verify.rb
          lookout/recorders/state/not/be.rb
          lookout/recorders/state/not/have.rb
          lookout/result.rb
          lookout/results.rb
          lookout/results/error.rb
          lookout/results/error/exception.rb
          lookout/results/error/exception/backtrace.rb
          lookout/results/failure.rb
          lookout/results/failures.rb
          lookout/results/failures/behavior.rb
          lookout/results/failures/state.rb
          lookout/results/fulfilled.rb
          lookout/results/trackers.rb
          lookout/results/trackers/failure.rb
          lookout/results/unsuccessful.rb
          lookout/ui.rb
          lookout/ui/console.rb
          lookout/warning.rb
        ',
        :manual => %w'
          lookout/version.rb
        '
      }
    end
  end
end
