# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Module.new(@expected, file, line, &block)
  end
end
