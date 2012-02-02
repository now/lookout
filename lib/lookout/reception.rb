# -*- coding: utf-8 -*-

class Lookout::Reception
  def initialize(object, method, *args, &body)
    @object, @method, @args, @body = object, method, args, body
    at_least_once
  end

  def never
    exactly(0)
  end

  def at_most_once
    at_most(1)
  end

  def once
    exactly(1)
  end

  def at_least_once
    at_least(1)
  end

  def twice
    exactly(2)
  end

  def at_most(times)
    range('cannot convert upper mock method invocation limit to Integer: %s', times){ |i|
      # TODO: Might want to remove this raise, as #at_most(0) is now the same
      # as #exactly(0).
      raise ArgumentError,
        'upper mock method invocation limit must be positive: %d < 1' % i if i < 1
      0..i
    }
  end

  def exactly(times)
    range('cannot convert expected mock method invocation count to Integer: %s', times){ |i|
      raise ArgumentError,
        'expected mock method invocation count must be non-negative: %d < 0' % i if i < 0
      i..i
    }
  end

  def at_least(times)
    range('cannot convert lower mock method invocation limit to Integer: %s', times){ |i|
      raise ArgumentError,
        'lower mock method invocation limit must be positive: %d < 1' % i if i < 1
      i..1.0/0
    }
  end

  def to_lookout_expected
    Lookout::Expected::Lookout::Reception.new(object, method, calls, *args, &body)
  end

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
