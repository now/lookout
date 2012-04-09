# -*- coding: utf-8 -*-

# Generates difference reports between {::Lookout::Reception}s.  Differences
# are seen when the number of times a method call is received isn’t within the
# range of expected number of receptions.
class Lookout::Difference::Lookout::Reception < Lookout::Difference::Range
  # @param [Integer] actual The actual number of receptions
  # @param [Range] expected The expected number of receptions
  # @param message Difference report generated from the method mock
  def initialize(actual, expected, message)
    super actual, expected
    @message = message
  end

  # @return [Enumerable] An Enumerable containing the difference report
  #   generated from the method mock
  def diff
    [@message]
  end
end
