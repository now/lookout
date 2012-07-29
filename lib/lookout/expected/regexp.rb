# -*- coding: utf-8 -*-

# Represents expected {::Regexp}s.
class Lookout::Expected::Regexp < Lookout::Expected::Object
  # @param [::Regexp] actual
  # @return [Difference::Regexp, nil] A difference report between _actual_ and
  #   {#expected} unless they’re `#==` or _actual_ is matched by {#expected}
  def difference(actual)
    Lookout::Difference::Regexp.new(actual, expected) unless
      expected == actual or expected === actual
  end
end
