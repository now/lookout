# -*- coding: utf-8 -*-

# Represents expected {::Module}s.
class Lookout::Expected::Module < Lookout::Expected::Object
  # @param [::Module] actual
  # @return [Difference::Module, nil] A difference report between ACTUAL and
  #   {#expected} unless they’re `#==` or ACTUAL is an {#expected}
  def difference(actual)
    Lookout::Difference::Module.new(actual, expected) unless
      expected == actual or expected === actual
  end
end
