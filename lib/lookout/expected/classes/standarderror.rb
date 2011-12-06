# -*- coding: utf-8 -*-

class Lookout::Expected::Classes::StandardError < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Classes::StandardError.new(@expected, file, line, &block)
  end
end
