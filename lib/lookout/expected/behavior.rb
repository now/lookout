# -*- coding: utf-8 -*-

class Lookout::Expected::Behavior < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Behavior.new(@expected, file, line, &block)
  end
end
