# -*- coding: utf-8 -*-

# Represents expected TrueClasses (of which `true` is the only instance).
class Lookout::Expected::TrueClass < Lookout::Expected::Object
  # @param [Boolean] actual
  # @return [Difference::Object] A difference report between ACTUAL and
  #   {#expected} unless ACTUAL is truthful
  def difference(actual) super((not not actual)) end
end
