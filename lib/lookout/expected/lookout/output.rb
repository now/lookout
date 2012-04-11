# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Output}s.
class Lookout::Expected::Lookout::Output < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Lookout::Expect::Lookout::Output] An expect block for the receiver
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Output.new(self, file, line, &block)
  end

  # @param [::Lookout::Output] other
  # @return [Lookout::Difference::Lookout::Output, nil] A difference report
  #   generator between _other_ and {#subject}, unless they’re `#==`
  def difference(other)
    Lookout::Difference::Lookout::Output.new(other, subject) unless
      subject == other
  end
end
