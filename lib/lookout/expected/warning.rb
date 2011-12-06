# -*- coding: utf-8 -*-

class Lookout::Expected::Warning < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Warning.new(@expected, file, line, &block)
  end
end
