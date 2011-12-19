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
    @calls = Lookout::Mock::Method::Calls::Upper.new(@method, times)
    self
  end

  def exactly(times)
    @calls = Lookout::Mock::Method::Calls::Exactly.new(@method, times)
    self
  end

  def at_least(times)
    @calls = Lookout::Mock::Method::Calls::Lower.new(@method, times)
    self
  end

  def to_lookout_expected
    Lookout::Expected::Reception.new(@object, @method, @calls, *@args, &@body)
  end
end
