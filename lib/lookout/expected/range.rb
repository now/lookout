# -*- coding: utf-8 -*-

# Represents expected {::Range}s.
class Lookout::Expected::Range < Lookout::Expected::Object
  # @param [::Range] other
  # @return [Lookout::Difference::Range, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re `#==` or _other_ lays
  #   within {#subject}
  def difference(other)
    Lookout::Difference::Range.new(other, subject) unless
      subject == other or
      subject === other
  end
end
