# -*- coding: utf-8 -*-

# Output expectation proxy.  Used to expect output on an IO object during the
# execution of an {Lookout::Expect expect block}.
class Lookout::Output
  # Proxies the _expected_ output.
  # @param [String] expected
  def initialize(expected)
    @expected = expected
  end

  # @param [Output] other
  # @return [Boolean] True if the receiver’s class and expected output `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and expected == other.expected
  end

  alias eql? ==

  def hash
    expected.hash
  end

  def inspect
    'output(%p)' % expected
  end

  # @param [Output] other
  # @return [Enumerable<String>] An Enumerable over the formatted operations
  #   that would have to be applied to the actual output to get the expected
  #   output
  def diff(other)
    expected.to_lookout_expected.difference(other.expected).diff
  end

  # @return [Expected::Lookout::Output] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Lookout::Output.new(self)
  end

  protected

  attr_reader :expected
end
