# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::Reception < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Recorders::Reception.new(@expected, file, line, &block)
  end
end
