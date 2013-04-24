# -*- coding: utf-8 -*-

# Represents expected {::Regexp}s.
class Lookout::Expected::Regexp < Lookout::Expected::Object
  # @param [::Regexp] actual
  # @return [Difference::Regexp, nil] A difference report between ACTUAL and
  #   {#expected} unless they’re `#==` or ACTUAL is matched by {#expected}
  def difference(actual)
    Lookout::Difference::Regexp.new(actual, expected) unless
      expected == actual or expected === actual
  end
end
