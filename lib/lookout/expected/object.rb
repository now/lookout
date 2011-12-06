# -*- coding: utf-8 -*-

class Lookout::Expected::Object
  def initialize(expected)
    @expected = expected
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Object.new(@expected, file, line, &block)
  end
end
