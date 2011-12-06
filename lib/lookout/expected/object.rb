# -*- coding: utf-8 -*-

class Lookout::Expected::Object
  def initialize(expected)
    @expected = expected
  end

  def =~(other)
    equality.equal?(@expected, other)
  end

  def message(other)
    equality.message(@expected, other)
  end

  def diff(other)
    equality.diff(@expected, other)
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Object.new(self, file, line, &block)
  end

  def subject
    @expected
  end

  private

  def equality
    @equality ||= Lookout::Equalities::Object.new
  end
end
