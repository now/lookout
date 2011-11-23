# -*- coding: utf-8 -*-

module Lookout
  Version = '2.4.0'

  class << Version
    def content
      {
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
          lookout/expectation.rb
          lookout/expectation/context.rb
          lookout/expectations.rb
          lookout/expectations/behavior.rb
          lookout/expectations/line.rb
          lookout/expectations/state.rb
          lookout/expectations/state/warning.rb
          lookout/inspect.rb
          lookout/inspect/actual.rb
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
          lookout/mock/method/calls/class.rb
          lookout/mock/method/calls/instance.rb
          lookout/mock/method/calls/exactly.rb
          lookout/mock/method/calls/lower.rb
          lookout/mock/method/calls/upper.rb
          lookout/mock/methods.rb
          lookout/mock/object.rb
          lookout/object/not.rb
          lookout/object/to.rb
          lookout/object/to/receive.rb
          lookout/recorder.rb
          lookout/recorder/tape.rb
          lookout/recorders.rb
          lookout/recorders/reception.rb
          lookout/recorders/state.rb
          lookout/recorders/state/be.rb
          lookout/recorders/state/have.rb
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
          lookout/results/unsuccessful.rb
          lookout/runners.rb
          lookout/runners/console.rb
          lookout/runners/trackers.rb
          lookout/runners/trackers/failure.rb
          lookout/ui.rb
          lookout/ui/console.rb
          lookout/ui/silent.rb
          lookout/warning.rb
          lookout/equality.rb
          lookout/equalities.rb
          lookout/equalities/object.rb
          lookout/equalities/array.rb
          lookout/equalities/boolean.rb
          lookout/equalities/hash.rb
          lookout/equalities/include.rb
          lookout/equalities/output.rb
          lookout/equalities/standarderror.rb
          lookout/equalities/string.rb
          lookout/equalities/warning.rb
        ',
        :manual => %w'
          lookout/version.rb
        '
      }
    end
  end
end
