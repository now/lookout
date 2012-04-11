# -*- coding: utf-8 -*-

# Represents expected {::Module}s.
class Lookout::Expected::Module < Lookout::Expected::Object
  # @param [::Module] other
  # @return [Lookout::Difference::Module, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re `#==` or _other_ is a
  #   {#subject}
  def difference(other)
    Lookout::Difference::Module.new(other, subject) unless
      subject == other or
      subject === other
  end
end
