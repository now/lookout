# -*- coding: utf-8 -*-

class Lookout::Mock::Method < Lookout::Stub::Method
  def initialize(object, method, *args, &body)
    super object, method, &body
    @args = Arguments.new(*args)
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

  def call(*args, &block)
    @calls.call
    @args.verify(*args)
    super
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  def verify
    @calls.verify
    self
  end

  def to_s
    '%s.%s%p' % [Lookout::Inspect.new(@object, 'object').call, @method, @args]
  end

  private

  def stash
    :"__mocked_method_#{@method}"
  end
end
