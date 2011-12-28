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
    calls(Lookout::Mock::Method::Calls::Upper,
          times,
          'cannot convert upper mock method invocation limit to Integer: %s')
  end

  def exactly(times)
    calls(Lookout::Mock::Method::Calls::Exactly,
          times,
          'cannot convert expected mock method invocation count to Integer: %s')
  end

  def at_least(times)
    calls(Lookout::Mock::Method::Calls::Lower,
          times,
          'cannot convert lower mock method invocation limit to Integer: %s')
  end

  def to_lookout_expected
    Lookout::Expected::Reception.new(@object, @method, @calls, *@args, &@body)
  end

  private

  def calls(calls, times, format)
    @calls = calls.new(begin times.to_int; rescue => e; raise e, format % e end)
    self
  end
end
