# -*- coding: utf-8 -*-

# Represents expected TrueClasses (of which `true` is the only instance).
class Lookout::Expected::TrueClass < Lookout::Expected::Object
  # @param [Boolean] other
  # @return [Lookout::Difference::Object] A difference report generator, unless
  #   _other_ is truthful
  def difference(other)
    super((not not other))
  end
end
