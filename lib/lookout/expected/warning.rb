# -*- coding: utf-8 -*-

class Lookout::Expected::Warning < Lookout::Expected::Output
  def to_lookout_expectation(file, line, &block)
    Lookout::Expect::Warning.new(self, file, line, &block)
  end

  def =~(other)
    subject === other or subject == other
  end
end
