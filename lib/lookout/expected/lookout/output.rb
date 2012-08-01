# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Output}s.
class Lookout::Expected::Lookout::Output < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Expect::Lookout::Output] An expect block for the receiver at
  #   _line_ in _file_ that’ll yield an IO object that’ll expect to see the
  #   {#expected} output during the execution of the block
  def expect(file, line, &block)
    super(file, line){ |expected|
      output = StringIO.new
      block.call output
      expected.class.new(output.string)
    }
  end

  # @param [::Lookout::Output] actual
  # @return [Difference::Lookout::Output, nil] A difference report between
  #   _actual_ and {#expected} unless they’re `#==`
  def difference(actual)
    Lookout::Difference::Lookout::Output.new(actual, expected) unless
      expected == actual
  end
end
