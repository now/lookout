# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Hash.new(@expected, file, line, &block)
  end
end
