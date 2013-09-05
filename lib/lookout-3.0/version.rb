# -*- coding: utf-8 -*-

require 'inventory-1.0'

module Lookout
  Version = Inventory.new(3, 0, 1){
    authors{
      author 'Nikolai Weibull', 'now@disu.se'
    }

    homepage 'http://disu.se/software/lookout/'

    licenses{
      license 'LGPLv3+',
              'GNU Lesser General Public License, version 3 or later',
              'http://www.gnu.org/licenses/'
    }

    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 6, 0
        development 'inventory-rake-tasks-yard', 1, 4, 0
        development 'lookout-rake', 3, 1, 0
        development 'yard', 0, 8, 0
        development 'yard-heuristics', 1, 1, 0
        development 'yard-value', 1, 2, 0

        runtime 'value', 1, 1, 0
      }
    end

    def requires
      %w[stringio]
    end

    def package_libs
      %w[object.rb
         aphonic.rb
         actual.rb
         actual/method.rb
         actual/not.rb
         actual/not/method.rb
         diff.rb
         diff/slice.rb
         diff/algorithms.rb
         diff/algorithms/difflib.rb
         diff/algorithms/difflib/position.rb
         diff/algorithms/difflib/position/new.rb
         diff/formats.rb
         diff/formats/inline.rb
         diff/formats/set.rb
         diff/formats/unified.rb
         diff/group.rb
         diff/groups.rb
         diff/match.rb
         diff/operation.rb
         diff/operations.rb
         diff/operations/delete.rb
         diff/operations/copy.rb
         diff/operations/insert.rb
         diff/operations/replace.rb
         difference.rb
         difference/object.rb
         difference/array.rb
         difference/exception.rb
         difference/hash.rb
         difference/range.rb
         difference/lookout.rb
         difference/lookout/actual.rb
         difference/lookout/actual/method.rb
         difference/lookout/actual/not.rb
         difference/lookout/actual/not/method.rb
         difference/lookout/output.rb
         difference/lookout/reception.rb
         difference/lookout/warning.rb
         difference/module.rb
         difference/regexp.rb
         difference/string.rb
         difference/symbol.rb
         encode.rb
         exception.rb
         exception/backtrace.rb
         exception/unknown.rb
         expect.rb
         expect/object.rb
         expect/object/context.rb
         expect/classes.rb
         expect/classes/exception.rb
         expect/exception.rb
         expected.rb
         expected/object.rb
         expected/array.rb
         expected/classes.rb
         expected/classes/exception.rb
         expected/exception.rb
         expected/falseclass.rb
         expected/hash.rb
         expected/lookout.rb
         expected/lookout/actual.rb
         expected/lookout/actual/method.rb
         expected/lookout/actual/not.rb
         expected/lookout/actual/not/method.rb
         expected/lookout/output.rb
         expected/lookout/reception.rb
         expected/lookout/warning.rb
         expected/module.rb
         expected/range.rb
         expected/regexp.rb
         expected/string.rb
         expected/symbol.rb
         expected/trueclass.rb
         expectations.rb
         expectations/context.rb
         inspect.rb
         interfaces.rb
         interfaces/commandline.rb
         literal.rb
         stub.rb
         mock.rb
         output.rb
         plugins.rb
         reception.rb
         reception/arguments.rb
         reception/arguments/any.rb
         reception/arguments/error.rb
         reception/arguments/list.rb
         reception/arguments/none.rb
         reception/error.rb
         object/not.rb
         object/not/receive.rb
         object/to.rb
         object/to/receive.rb
         result.rb
         results.rb
         results/error.rb
         results/failure.rb
         results/success.rb
         warning.rb]
    end

    def additional_unit_tests
      %w[examples.rb]
    end
  }
end
