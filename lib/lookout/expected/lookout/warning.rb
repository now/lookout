# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Warning}s.
class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Expect::Lookout::Warning] An expect block for the receiver at
  #   _line_ in _file_ that’ll yield the {#expected} warning and expect the
  #   warning to be output output during the execution of the block
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  # @param [::Lookout::Warning] actual
  # @return [Difference::Lookout::Warning, nil] A difference report between
  #   _actual_ and {#expected} unless they’re `#===`
  def difference(actual)
    Lookout::Difference::Lookout::Warning.new(actual, expected) unless
      expected === actual
  end
end
