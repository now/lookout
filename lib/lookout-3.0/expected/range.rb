# -*- coding: utf-8 -*-

# Represents expected {::Range}s.
class Lookout::Expected::Range < Lookout::Expected::Object
  # @param [::Range] actual
  # @return [Difference::Range, nil] A difference report between ACTUAL and
  #   {#expected} unless they’re `#==` or ACTUAL lays within {#expected}
  def difference(actual)
    Lookout::Difference::Range.new(actual, expected) unless
      expected == actual or expected === actual
  end
end
