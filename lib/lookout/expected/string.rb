# -*- coding: utf-8 -*-

# Represents expected {::String}s.
class Lookout::Expected::String < Lookout::Expected::Object
  # @param [::String] other
  # @return [Lookout::Difference::String, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re `#==`
  def difference(other)
    Lookout::Difference::String.new(other, subject) unless subject == other
  end
end
