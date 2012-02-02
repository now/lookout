# -*- coding: utf-8 -*-

class Lookout::Difference::Array < Lookout::Difference::Object
  def diff
    return super if @expected.size == 1 or not ::Array === @actual
    ::Lookout::Diff::Formats::Unified.
      new(::Lookout::Diff::Groups.
            new(::Lookout::Diff::Operations.
                  new(::Lookout::Diff::Algorithms::Difflib.
                        new(@actual, @expected))))
  end
end
