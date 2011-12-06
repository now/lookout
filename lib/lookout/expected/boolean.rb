# -*- coding: utf-8 -*-

class Lookout::Expected::Boolean < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Boolean.new(@expected, file, line, &block)
  end
end
