# -*- coding: utf-8 -*-

# Output expectation proxy.  Used to expect output on an IO object during the
# execution of an {Lookout::Expect expect block}.
class Lookout::Output
  # @param [String] output The expected output
  def initialize(output)
    @output = output
  end

  # @param [Output] other
  # @return [Boolean] True if the receiver’s class and expected output `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and
      output == other.output
  end

  alias eql? ==

  def hash
    self.class.hash ^ output.hash
  end

  def inspect
    'output(%p)' % output
  end

  # @param [Output] other
  # @return [Enumerable] An Enumerable over the formatted operations that would
  #   have to be applied to the actual output to get the expected output
  def diff(other)
    output.to_lookout_expected.difference(other.output).diff
  end

  # @return [Expected::Lookout::Output] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Lookout::Output.new(self)
  end

  protected

  attr_reader :output
end
