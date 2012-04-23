# -*- coding: utf-8 -*-

# Base class for errors raised when the actual number of calls made to a mock
# method don’t match the expected number of calls.
class Lookout::Mock::Method::Calls::Error < Lookout::Mock::Error
  # Initializes the error with _message_ and the actual number of _calls_ made
  # and their expected _range_.
  # @param [String] message
  # @param [Integer] calls
  # @param [Range] range
  def initialize(message, calls, range)
    super message
    @calls, @range = calls, range
  end

  # @return True if the receiver’s class, {#calls}, and {#range} `#==` those of
  #   _other_
  def ==(other)
    super and
      self.class == other.class and
      calls == other.calls and
      range == other.range
  end

  def hash
    @hash ||= [calls, range].hash
  end

  # @return [Integer] The actual number of calls made
  attr_reader :calls

  # @return [Range] The expected number of calls
  attr_reader :range
end
