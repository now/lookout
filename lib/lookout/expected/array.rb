# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Array.new(@expected, file, line, &block)
  end
end
