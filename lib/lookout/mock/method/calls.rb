# -*- coding: utf-8 -*-

# Tracks the range of expected method calls and the actual method calls made.
class Lookout::Mock::Method::Calls
  # Allows a number of calls within _range_.
  # @param [Range] range
  def initialize(range)
    @range = range
    @calls = 0
  end

  # Increases the call count.
  # @return [self]
  # @raise [Calls::TooManyError] If the method was called more than the
  #   expected maximum number of times
  def call
    self.calls += 1
    error TooManyError if calls > range.end
    self
  end

  # Verifies that the appropriate number of calls were made to the method.
  # @return [self]
  # @raise [Calls::TooFewError] If the method wasn’t called the expected
  #   minimum number of times
  def verify
    error TooFewError unless range === calls
    self
  end

  # @return True if the receiver’s class, expected number of calls, and actual
  #   call count `#==` those of _other_
  def ==(other)
    self.class == other.class and range == other.range and calls == other.calls
  end

  alias eql? ==

  def hash
    [range, calls].hash
  end

  # @return [String] A String representation of the expected number of calls
  def to_s
    if range.begin == range.end
      range.begin.to_s
    elsif range.end == 1.0/0
      '%d..' % range.begin
    else
      range.to_s
    end
  end

  protected

  attr_reader :range, :calls
  attr_writer :calls

  private

  def error(type)
    raise type.
      new('unexpected number of invocations (%d for %s)' % [calls, self],
          calls,
          range)
  end
end
