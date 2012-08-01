# -*- coding: utf-8 -*-

# Method reception expectation builder.  Method reception expectations can set
# expectations on what method is going to be called, with what arguments, and
# how many times it’s to take place.
class Lookout::Reception
  Value(:object, :method, :range, :'*args', :'&body')
  # @return [Range] The range of number of times that the method may be called
  public :range

  class << self
    # @param [Symbol] method
    # @param [Object, …] args
    # @return [Lookout::Reception] A reception expectation expecting _method_
    #   to be called on _object_ with _args_, using _body_ as the method
    #   definition.
    def of(object, method, *args, &body)
      new(object, method, 1..1.0/0, *args, &body)
    end

    private :new
  end

  # This is an alias for {#exactly}(0).
  def never; exactly(0) end

  # This is an alias for {#at_most}(1).
  def at_most_once; at_most(1) end

  # This is an alias for {#exactly}(1).
  def once; exactly(1) end

  # This is an alias for {#at_least}(1).
  def at_least_once; at_least(1) end

  # This is an alias for {#exactly}(2).
  def twice; exactly(2) end

  # @param [Integer] times
  # @return [Lookout::Reception] A reception expectation with a maximum number
  #   of _times_ that the method may be called
  # @raise [ArgumentError] If _times_ < 1
  def at_most(times)
    limit('cannot convert upper reception limit to Integer: %s', times){ |i|
      raise ArgumentError,
        'upper reception limit must be positive: %d < 1' % i if i < 1
      0..i
    }
  end

  # @param [Integer] times
  # @return [Lookout::Reception] A reception expectation with a minimum and
  #   maximum number of _times_ that the method may be called
  # @raise [ArgumentError] If _times_ < 0
  def exactly(times)
    limit('cannot convert reception invocation count to Integer: %s', times){ |i|
      raise ArgumentError,
        'expected reception count must be non-negative: %d < 0' % i if i < 0
      i..i
    }
  end

  # Sets the minimum number of times that the method may be called.
  # @param [Integer] times
  # @return [Lookout::Reception] A reception expectation with a minimum number
  #   of _times_ that the method may be called
  # @raise [ArgumentError] If _times_ < 1
  def at_least(times)
    limit('cannot convert lower reception limit to Integer: %s', times){ |i|
      raise ArgumentError,
        'lower reception limit must be positive: %d < 1' % i if i < 1
      i..1.0/0
    }
  end

  # @return [Expected::Lookout::Reception] A wrapper around the object that
  #   represents the expected reception of this method
  def to_lookout_expected
    Lookout::Expected::Lookout::Reception.new(self)
  end

  # @return [Proc] A block to be used by {Expected::Lookout::Reception#expect}
  #   that’ll set up a stub for the expected method reception that’ll check
  #   that the call count doesn’t exceed any upper limit imposed upon it and
  #   verify that any arguments are what they’re expected to be and then invoke
  #   _block_
  def block(&block)
    args, calls = Lookout::Reception::Arguments.new(*@args), 0
    reception, object, method, range, body = self, @object, @method, @range, @body || Nil
    proc{
      stub(object, method => proc{ |*mock_args, &mock_block|
             calls += 1
             raise Lookout::Reception::Error.
               from(reception, calls, range) if calls > range.end
             begin
               args.verify(*mock_args)
             rescue Lookout::Reception::Arguments::Error => e
               raise e, '%s: %s' % [reception, e]
             end
             body.call(*mock_args, &mock_block)
           }, &block) if block
      calls
    }
  end

  def to_s
    [Lookout::Inspect.new(object, 'object'),
     Class === object ? '.' : '#',
     method].join('')
  end

  private

  def limit(format, times)
    self.class.send(:new,
                    object,
                    method,
                    yield(begin
                            times.to_int
                          rescue => e
                            raise e, format % e
                          end),
                    *args,
                    &body)
  end

  Nil = proc{ Lookout::Stub.new }
end
