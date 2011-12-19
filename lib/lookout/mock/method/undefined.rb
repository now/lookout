# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  def initialize(object, method, args, calls = Calls::Lower.new(self, 1), &body)
    super object, method, args, calls, &body
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
    @calls = Calls::Upper.new(self, times)
    self
  end

  def exactly(times)
    @calls = Calls::Exactly.new(self, times)
    self
  end

  def at_least(times)
    @calls = Calls::Lower.new(self, times)
    self
  end

  private

  def defined
    Defined.new(@object, @method, @args, @calls, &@body)
  end
end
