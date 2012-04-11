# -*- coding: utf-8 -*-

# Represents expected FalseClasses (of which `false` is the only instance).
class Lookout::Expected::FalseClass < Lookout::Expected::Object
  # @param [Boolean] other
  # @return [Lookout::Difference::Object] A difference report generator, unless
  #   _other_ is falseful
  def difference(other)
    super((not not other))
  end
end
