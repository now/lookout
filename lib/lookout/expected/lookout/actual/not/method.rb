# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Actual::Not::Method}s.
class Lookout::Expected::Lookout::Actual::Not::Method < Lookout::Expected::Object
  # @param [::Object] actual
  # @return [Difference::Lookout::Actual::Not::Method, nil] A difference report
  #   between ACTUAL and {#expected} unless invoking {#expected} on ACTUAL
  #   returns false
  def difference(actual)
    Lookout::Difference::Lookout::Actual::Not::Method.new(actual, expected) if
      expected.call(actual)
  end
end
