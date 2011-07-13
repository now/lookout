# -*- coding: utf-8 -*-

class Lookout::Equalities::Array < Lookout::Equalities::Object
  Lookout::Equality.register self, Array

  def equal?(expected, actual)
    return false unless Array === actual and expected.size == actual.size
    expected.each_with_index do |v, i|
      return false unless Lookout::Equality.equal? v, actual[i]
    end
    true
  end

  def diff(expected, actual)
    return if expected.size == 1 or not Array === actual
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
                        new(actual, expected)))).to_a.join("\n")
  end
end
