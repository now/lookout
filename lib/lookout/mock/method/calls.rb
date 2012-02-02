# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls
  class Error < Lookout::Mock::Error
    def initialize(message, calls, range)
      super message
      @calls, @range = calls, range
    end

    def ==(other)
      super and
        self.class == other.class and
        calls == other.calls and
        range == other.range
    end

    attr_reader :calls, :range
  end

  TooManyError = Class.new(Error)
  TooFewError = Class.new(Error)

  def initialize(range)
    @range = range
    @calls = 0
  end

  def call
    self.calls += 1
    error TooManyError if calls > range.end
    self
  end

  def verify
    error TooFewError unless range === calls
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

  def error(type)
    raise type.
      new('unexpected number of invocations (%d for %s)' % [calls, self],
          calls,
          range)
  end
end
