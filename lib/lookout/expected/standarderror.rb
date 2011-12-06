# -*- coding: utf-8 -*-

class Lookout::Expected::StandardError < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::StandardError.new(@expected, file, line, &block)
  end
end
