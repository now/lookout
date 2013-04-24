# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Actual::Method}s.
class Lookout::Expected::Lookout::Actual::Method < Lookout::Expected::Object
  # @param [::Object] actual
  # @return [Difference::Lookout::Actual::Method, nil] A difference report
  #   between ACTUAL and {#expected} unless invoking {#expected} on ACTUAL
  #   returns true
  def difference(actual)
    Lookout::Difference::Lookout::Actual::Method.new(actual, expected) unless
      expected.call(actual)
  end
end
