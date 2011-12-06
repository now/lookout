# -*- coding: utf-8 -*-

class Lookout::Expected::Object
  def initialize(expected)
    @expected = expected
  end

  def =~(other)
    @expected == other
  end

  def message(other)
    begin
      format = format(other)
    rescue => e
      raise if Lookout::Expected::Object == self.class rescue true
      return '%s (cannot generate more specific failure message: %s)' %
        [Lookout::Expected::Object.new(@expected).message(other), e.message]
    end
    begin
      diff = diff(other)
    rescue => e
      diff = '(cannot diff expected value and actual result: %s)' % e.message
    end
    diff ? (diff.include?("\n") ? "%s\n%s" : '%s: %s') % [format, diff] : format
  end

  def diff(other)
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Object.new(self, file, line, &block)
  end

  def subject
    @expected
  end

  private

  def format(other)
    '%s≠%s' % [Lookout::Inspect::Actual.new(other).call,
               Lookout::Inspect::Expected.new(@expected).call]
  end
end
