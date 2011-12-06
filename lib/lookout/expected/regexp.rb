# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Regexp.new(@expected, file, line, &block)
  end
end
