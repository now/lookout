# -*- coding: utf-8 -*-

# Method reception expectations builder.  Method reception expectations can set
# expectations on what method is going to be called, with what arguments, and
# how many times it’s to take place.
class Lookout::Reception
  # @param [Object] object The object expecting a method reception
  # @param [Symbol] method The method name
  # @param [Object, …] *args The expected method arguments
  # @param [Proc] &body The block to use as a method definition
  def initialize(object, method, *args, &body)
    @object, @method, @args, @body = object, method, args, body
    at_least_once
  end

  # This is an alias for {#exactly}(0).
  def never
    exactly(0)
  end

  # This is an alias for {#at_most}(1).
  def at_most_once
    at_most(1)
  end

  # This is an alias for {#exactly}(1).
  def once
    exactly(1)
  end

  # This is an alias for {#at_least}(1).
  def at_least_once
    at_least(1)
  end

  # This is an alias for {#exactly}(2).
  def twice
    exactly(2)
  end

  # Sets the expected maximum number of times the method should be called to
  # _times_.
  # @param [Integer] times
  # @return [self]
  # @raise [ArgumentError] If _times_ < 1
  def at_most(times)
    range('cannot convert upper mock method invocation limit to Integer: %s', times){ |i|
      raise ArgumentError,
        'upper mock method invocation limit must be positive: %d < 1' % i if i < 1
      0..i
    }
  end

  # Sets the expected minimum and maximum number of times the method should be
  # called to _times_.
  # @param [Integer] times
  # @return [self]
  # @raise [ArgumentError] If _times_ < 0
  def exactly(times)
    range('cannot convert expected mock method invocation count to Integer: %s', times){ |i|
      raise ArgumentError,
        'expected mock method invocation count must be non-negative: %d < 0' % i if i < 0
      i..i
    }
  end

  # Sets the expected minimum number of times the method should be called to
  # _times_.
  # @param [Integer] times
  # @return [self]
  # @raise [ArgumentError] If _times_ < 1
  def at_least(times)
    range('cannot convert lower mock method invocation limit to Integer: %s', times){ |i|
      raise ArgumentError,
        'lower mock method invocation limit must be positive: %d < 1' % i if i < 1
      i..1.0/0
    }
  end

  # @return [Expected::Lookout::Reception] A wrapper around the object that
  #   represents the expected reception of this method
  def to_lookout_expected
    Lookout::Expected::Lookout::Reception.new(object, method, calls, *args, &body)
  end

  # @param [Reception] other
  # @return [Boolean] True if the receiver’s class, object, method, expected
  #   number of calls, expected argumets, and method definition `#==` those of
  #   _other_
  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      calls == other.calls and
      args == other.args and
      body == other.body
  end

  alias eql? ==

  def hash
    [self.class, object, method, calls, args, body].hash
  end

  protected

  attr_reader :object, :method, :calls, :args, :body
  attr_writer :calls

  private

  def range(format, times)
    self.calls = Lookout::Mock::Method::Calls.new(yield begin
                                                    times.to_int
                                                  rescue => e
                                                    raise e, format % e
                                                  end)
    self
  end
end
