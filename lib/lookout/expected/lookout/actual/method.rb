# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Actual::Method}s.
class Lookout::Expected::Lookout::Actual::Method < Lookout::Expected::Object
  # @param [::Object] actual
  # @return [Difference::Lookout::Actual::Method, nil] A difference report
  #   between _actual_ and {#expected} unless invoking {#expected} on _actual_
  #   returns true
  def difference(actual)
    Lookout::Difference::Lookout::Actual::Method.new(actual, expected) unless
      expected.call(actual)
  end
end
