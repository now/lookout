# -*- coding: utf-8 -*-

# Base class for errors raised when the actual number of calls made to a mock
# method don’t match the expected number of calls.
class Lookout::Mock::Method::Calls::Error < Lookout::Mock::Error
  # @param [String] message The error message
  # @param [Integer] calls The actual number of calls made
  # @param [Range] range The expected number of calls
  def initialize(message, calls, range)
    super message
    @calls, @range = calls, range
  end

  # @param [Error] other
  # @return [Boolean] True if the receiver’s class, {#calls}, and {#range}
  #   `#==` those of _other_
  def ==(other)
    super and
      self.class == other.class and
      calls == other.calls and
      range == other.range
  end

  # @return [Integer] The actual number of calls made
  attr_reader :calls

  # @return [Range] The expected number of calls
  attr_reader :range
end
