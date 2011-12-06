# -*- coding: utf-8 -*-

class Lookout::Expected::Warning < Lookout::Expected::Output
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Warning.new(self, file, line, &block)
  end

  def =~(other)
    @expected === other or @expected == other
  end
end
