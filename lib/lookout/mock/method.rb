# -*- coding: utf-8 -*-

class Lookout::Mock::Method < Lookout::Stub::Method
  autoload :Arguments, 'lookout/mock/method/arguments'
  autoload :Calls, 'lookout/mock/method/calls'

  def initialize(object, method, *args, &body)
    super object, method, &body
    @args = Arguments.new(*args)
    # TODO: Should this be #once?
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
    '%s.%s%s' % [@object.inspect, @method, @args]
  end

private

  def stash
    :"__mocked_method_#{@method}"
  end
end
