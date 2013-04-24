# -*- coding: utf-8 -*-

# Represents expected {::String}s.
class Lookout::Expected::String < Lookout::Expected::Object
  # @param [::String] actual
  # @return [Difference::String, nil] A difference report between ACTUAL and
  #   {#expected} unless they’re `#==`
  def difference(actual)
    Lookout::Difference::String.new(actual, expected) unless expected == actual
  end
end
