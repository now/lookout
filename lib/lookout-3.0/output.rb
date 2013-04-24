# -*- coding: utf-8 -*-

# Output expectation proxy.  Used to expect output on an IO object during the
# execution of an {Lookout::Expect expect block}.
class Lookout::Output
  # Proxies the EXPECTED output.
  # @param [String] expected
  Value(:expected)

  def inspect; 'output(%p)' % expected end

  # @return [Enumerable<String>] An Enumerable over the formatted operations
  #   that would have to be applied to the actual output to get the expected
  #   output
  def diff(other) expected.to_lookout_expected.difference(other.expected).diff end

  # @return [Expected::Lookout::Output] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Lookout::Output.new(self) end
end
