# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::State < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Recorders::State.new(@expected, file, line, &block)
  end
end
