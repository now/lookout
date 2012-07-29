# -*- coding: utf-8 -*-

# Represents expected TrueClasses (of which `true` is the only instance).
class Lookout::Expected::TrueClass < Lookout::Expected::Object
  # @param [Boolean] actual
  # @return [Difference::Object] A difference report between _actual_ and
  #   {#expected} unless _actual_ is truthful
  def difference(actual) super((not not actual)) end
end
