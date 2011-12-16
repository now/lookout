# -*- coding: utf-8 -*-

class Lookout::Expected::Output < Lookout::Expected::Object
  def to_lookout_expectation(file, line, &block)
    Lookout::Expect::Output.new(self, file, line, &block)
  end

  def diff(other)
    subject.diff(other)
  end
end
