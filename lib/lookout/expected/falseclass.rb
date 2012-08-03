# -*- coding: utf-8 -*-

# Represents expected FalseClasses (of which `false` is the only instance).
class Lookout::Expected::FalseClass < Lookout::Expected::Object
  # @param [Boolean] actual
  # @return [Difference::Object] A difference report between ACTUAL and
  #   {#expected} unless ACTUAL is falseful
  def difference(actual) super((not not actual)) end
end
