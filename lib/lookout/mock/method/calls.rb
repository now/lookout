# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)
  TooManyError = Class.new(Error)
  TooFewError = Class.new(Error)

  def initialize(limit)
    @limit = limit
    @calls = 0
  end

  def call
    self.calls += 1
    error TooManyError if surpassed?
    self
  end

  def verify
    error TooFewError unless satisfied?
    self
  end

  def ==(other)
    self.class == other.class and
      limit == other.limit and
      calls == other.calls
  end

  protected

  attr_reader :limit, :calls
  attr_writer :calls

  private

  def surpassed?
    calls > limit
  end

  def error(type)
    raise type, 'unexpected number of invocations (%d for %s)' % [calls, self]
  end
end
