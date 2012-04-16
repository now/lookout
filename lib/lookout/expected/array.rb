# -*- coding: utf-8 -*-

# Represents expected {::Array}s.
class Lookout::Expected::Array < Lookout::Expected::Object
  # @param [::Array] actual
  # @return [Difference::Array, nil] A difference report between _actual_ and
  #   {#expected} unless their content exhibit no {Object differences}
  def difference(actual)
    Lookout::Difference::Array.new(actual, expected) unless
      Array === actual and
      expected.size == actual.size and
      expected.enum_for(:none?).with_index{ |v, i|
        v.to_lookout_expected.difference(actual[i])
      }
  end
end
