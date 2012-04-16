# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Reception}s.  Differences are seen
# when the number of times a method call is received isn’t within the range of
# expected number of receptions.
class Lookout::Difference::Lookout::Reception < Lookout::Difference::Range
  # Uses _message_ as the difference report between the _actual_ number of
  # receptions against the range of _expected_ number of receptions.
  # @param [Integer] actual
  # @param [Range] expected
  # @param [String] message
  def initialize(actual, expected, message)
    super actual, expected
    @message = message
  end

  # @return [Enumerable<String>] An Enumerable containing the difference report
  #   message generated from the method mock
  def diff
    [@message]
  end
end
