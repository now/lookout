# -*- coding: utf-8 -*-

# Represents expected {::Hash}es.
class Lookout::Expected::Hash < Lookout::Expected::Object
  # @param [::Hash] actual
  # @return [Difference::Hash, nil] A difference report between ACTUAL and
  #   {#expected} unless their content exhibit no {Object differences}
  def difference(actual)
    Lookout::Difference::Hash.new(actual, expected) unless
      Hash === actual and
      expected.size == actual.size and
      expected.none?{ |k, v| v.to_lookout_expected.difference(actual[k]) }
  end
end
