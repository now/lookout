# -*- coding: utf-8 -*-

class Lookout::Difference::Object
  def initialize(actual, expected)
    @actual, @expected = actual, expected
  end

  def message
    '%s%s%s' % order
  end

  def diff
    []
  end

  def ==(other)
    self.class == other.class and
      message == other.message and
      diff.to_s == other.diff.to_s
  end

  attr_reader :actual, :expected

  private

  def order
    [inspect_actual, symbol, inspect_expected]
  end

  def inspect_actual
    Lookout::Inspect::Actual.new(actual).call
  end

  def inspect_expected
    Lookout::Inspect::Expected.new(expected).call
  end

  def symbol
    '≠'
  end
end
