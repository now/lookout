# -*- coding: utf-8 -*-

class Lookout::Expected::Output < Lookout::Expected::Object
  def actualize(file, line, &block)
    Lookout::Expect::Output.new(self, file, line, &block)
  end

  def diff(other)
    subject.diff(other)
  end
end
