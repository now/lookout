# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)
  TooManyError = Class.new(Error)
  TooFewError = Class.new(Error)

  def initialize(range)
    @range = range
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
      range == other.range and
      calls == other.calls
  end

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

  def surpassed?
    calls > range.end
  end

  def satisfied?
    range === calls
  end

  def error(type)
    raise type, 'unexpected number of invocations (%d for %s)' % [calls, self]
  end
end
