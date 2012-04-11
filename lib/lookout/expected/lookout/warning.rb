# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Warning}s.
class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Lookout::Expect::Lookout::Output] An expect block for the receiver
  # @extension
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  # @param [::Lookout::Warning] other
  # @return [Lookout::Difference::Lookout::Warning, nil] A difference report
  #   generator between _other_ and {#subject}, unless they’re `#===` or `#==`
  def difference(other)
    Lookout::Difference::Lookout::Warning.new(other, subject) unless
      subject === other or
      subject == other
  end
end
