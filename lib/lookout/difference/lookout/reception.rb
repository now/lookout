# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Reception}s.  Differences are seen
# when the number of times a method call is received isn’t within the range of
# expected number of receptions.
class Lookout::Difference::Lookout::Reception < Lookout::Difference::Range
  # Initializes a difference report between the _actual_ number of receptions
  # against the range of _expected_ number of receptions.
  # @param [Integer] actual
  # @param [Range] expected
  def initialize(actual, expected)
    super actual, expected.range
    @reception = expected
  end

  # @return [Enumerable<::String>] An Enumerable containing the difference
  #   report message generated from the method mock
  def diff
    [Lookout::Reception::Error.from(@reception, actual, expected).message]
  end
end
