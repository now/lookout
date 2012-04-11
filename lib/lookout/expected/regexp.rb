# -*- coding: utf-8 -*-

# Represents expected {::Regexp}s.
class Lookout::Expected::Regexp < Lookout::Expected::Object
  # @param [::Regexp] other
  # @return [Lookout::Difference::Regexp, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re `#==` or _other_ is
  #   matched by {#subject}
  def difference(other)
    Lookout::Difference::Regexp.new(other, subject) unless
      subject == other or
      subject === other
  end
end
